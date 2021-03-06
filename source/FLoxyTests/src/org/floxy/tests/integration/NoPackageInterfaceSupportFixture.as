package org.floxy.tests.integration
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.system.ApplicationDomain;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	import org.floxy.IProxyRepository;
	import org.floxy.ProxyRepository;
	import org.floxy.tests.*;
	
	[TestCase]
	public class NoPackageInterfaceSupportFixture
	{
		private var _proxyRepository : IProxyRepository;
		
		[Before(async)]
		public function setupProxy() : void
		{
			_proxyRepository = new ProxyRepository();
			
			var result : IEventDispatcher = 
					_proxyRepository.prepare([INoPackageReferenceInterface], ApplicationDomain.currentDomain);
					
			result.addEventListener(Event.COMPLETE, Async.asyncHandler(this, function(... args):void
			{
								
			}, 1000));
		}
		
		[Test]
		public function can_be_accessed_directly() : void
		{
			var interceptor : MockIntercepter = new MockIntercepter();
			
			var a : INoPackageReferenceInterface =
				INoPackageReferenceInterface(_proxyRepository.create(INoPackageReferenceInterface, [], interceptor));
			
			a.getValue();
			
			Assert.assertEquals(1, interceptor.invocationCount);
		}
	}
}

