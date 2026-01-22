Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13130352F85
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Jan 2026 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087442; cv=none; b=EpxTAHRiDFVvEVF+KvNj6PRAfeBvcjYaveT5pwq5iQuhSS7lMRuNuoXhw6bwSoCJhbkE+VAEgSBxaCVXIEG/2XXFHk46ddu6IRccIF+Vyvw50TyxoymEkJbCICCkzR6dtLbsbWAHm71LlMRrl0tTh3qqcNxZEkTVs8UX2Zy8U34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087442; c=relaxed/simple;
	bh=JUNOyJdtlwXjmy1eINMRCldE6dhFyGhuj8uxUB2FTEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0B4jFFtWryTZuMT5Q2hy+2jU0CLLw+Aht2wpYjOEpAo7HemfuEDn7lWPN36HcC8rZC/pT9j6qWaFNU/fDr9AaNj6/DJd1HPXi4D30aj/eBxOjOmBVib8QkX6oII+GsiSQvIMR5G7BIP7kdTqie73lKLhM/4ubqrSLpqbIwG2MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i25Muqtj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i25Muqtj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769087439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SALYnuAnnYA1nhqpGRsYR5wyQImDBQy6AA8FqVLTFIs=;
	b=i25Muqtjj/x7sc3ExDMtRjaTJoxj9MN/ZFM197zxYiRh+69qMXl39RTnDqqKa/JZcFAETH
	7PiGLhHxx2gV7Mqw2Aj0OqnAPqLIwRjXTT8lC9/QDdrXghXH1hegcn01zPU4hFAR2UtQNQ
	nx7SRNR+KyIr670dJg5j5w9vzzEKOZQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-4LaFYuw7OsWUxtqjKzEvCw-1; Thu,
 22 Jan 2026 08:10:31 -0500
X-MC-Unique: 4LaFYuw7OsWUxtqjKzEvCw-1
X-Mimecast-MFC-AGG-ID: 4LaFYuw7OsWUxtqjKzEvCw_1769087430
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B7CF1829E35;
	Thu, 22 Jan 2026 13:10:25 +0000 (UTC)
Received: from fedora (unknown [10.22.80.75])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EF938180099E;
	Thu, 22 Jan 2026 13:10:22 +0000 (UTC)
Date: Thu, 22 Jan 2026 10:10:21 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:RUNTIME VERIFICATION (RV)" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 18/26] rv/rvgen: add fill_tracepoint_args_skel stub to
 ltl2k
Message-ID: <aXIhSGAQvflGAEsN@fedora>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-19-wander@redhat.com>
 <1f168ff5ffb531570fd83e3f398380e8df053275.camel@redhat.com>
 <aXESFlL56FA0PyTZ@fedora>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXESFlL56FA0PyTZ@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Jan 21, 2026 at 02:53:03PM -0300, Wander Lairson Costa wrote:
> On Wed, Jan 21, 2026 at 02:57:02PM +0100, Gabriele Monaco wrote:
> > On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> > > The ltl2k class inherits from Monitor which requires subclasses to
> > > implement fill_tracepoint_args_skel(). However, the ltl2k template
> > > uses hardcoded tracepoint arguments rather than the placeholders that
> > > this method would fill. The base class fill_trace_h() method calls
> > > fill_tracepoint_args_skel() unconditionally, which was exposed when
> > > the @not_implemented decorator was introduced.
> > > 
> > > Add a stub implementation that returns an empty string. Since the
> > > ltl2k trace.h template does not contain the placeholder strings that
> > > would be replaced, the empty return value has no effect on the
> > > generated output while satisfying the base class interface contract.
> > > 
> > > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > 
> > Mmh, this is a bit fishy though.
> > We the patch using the decorator seems fine, but highlights how this method
> > isn't meant to be in Monitor if not all monitors use it..
> > Adding a stub here is just sweeping dust under the carpet.
> > 
> > Here should probably keep the common part of fill_trace_h() in Monitor (e.g.
> > replacing MODEL_NAME and other common things) and create specific
> > implementations in dot2k and ltl2k for what is not common while calling the
> > super() counterpart for the rest.
> > 
> > Does it make sense to you?
> > 
> 
> Yes, that is exactly my idea. Since the patch series were getting too
> long and my brain too rot, I thought would be better addressing this in
> a following up patch series. But I can work in the next version if you
> are not ok with that approach.
> 

I gave more thought on this matter yesterday before bed. Maybe this
isn't a issue on the design. Some methods on Monitor might just have a
harmless default behavior. I look into it more closely for next the
round.

> > Thanks,
> > Gabriele
> > 
> > > ---
> > >  tools/verification/rvgen/rvgen/ltl2k.py | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/tools/verification/rvgen/rvgen/ltl2k.py
> > > b/tools/verification/rvgen/rvgen/ltl2k.py
> > > index 94dc64af1716d..f1eafc16c754b 100644
> > > --- a/tools/verification/rvgen/rvgen/ltl2k.py
> > > +++ b/tools/verification/rvgen/rvgen/ltl2k.py
> > > @@ -257,6 +257,9 @@ class ltl2k(generator.Monitor):
> > >  
> > >          return '\n'.join(buf)
> > >  
> > > +    def fill_tracepoint_args_skel(self, tp_type) -> str:
> > > +        return ""
> > > +
> > >      def fill_monitor_class_type(self):
> > >          return "LTL_MON_EVENTS_ID"
> > >  
> > 
> 

