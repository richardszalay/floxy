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
	import org.floxy.tests.util.ProxyRepositoryUtil;
	
	[TestCase]
	public class NoPackageClassSupportFixture
	{
		private var _proxyRepository : ProxyRepository;
		
		[Before(async)]
		public function setupProxy() : void
		{
			_proxyRepository = new ProxyRepository();
			
			var result : IEventDispatcher = 
					_proxyRepository.prepare([NoPackageReferenceClass], ApplicationDomain.currentDomain);
					
			result.addEventListener(Event.COMPLETE, Async.asyncHandler(this, function(... args):void
			{
								
			}, 1000));
		}
		
		[Test]
		public function can_be_accessed_directly() : void
		{
			var interceptor : MockIntercepter = new MockIntercepter();
			
			var a : NoPackageReferenceClass =
				NoPackageReferenceClass(_proxyRepository.create(NoPackageReferenceClass, [], interceptor));
			
			a.getValue();
			
			Assert.assertEquals(1, interceptor.invocationCount);
		}
	}
}

