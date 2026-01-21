Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DB8329373
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Jan 2026 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769017994; cv=none; b=g31C69/xwkd6FyOaual4UGHYBykhn5j4bTN7ejzAzb2RvkXEGdDjqWSC0OEwNxU/GktNqjqZSoMZVlVxVcmRjAexqPxaENByJCbQ4h2VywRgjMVjHOiKc7C0ksVg/gsdcieXMnFawaZQSjHnO476DSfHmRD7K4a2ov+k3l10Kx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769017994; c=relaxed/simple;
	bh=NEimmM5KesNBKAwpVzd9LcZRj4gB0DuqH1kfwpKMGNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SknbqCZXdYfdz1FDKA45dxVVCW2MfvaYPwYIzouj6ku08EBGRDKfCnSdgeekNkI89K392YcIvcqCD2GvRUQUDYonb2f6D5zC4HmjdePyJiIyUyiKMYiwhCPX3BhtXqDuCogN+/LQMPJsNg05d/ErgY6pJ6IOeIR34TBkg1ecPwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fcE3tcuN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcE3tcuN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769017991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jwahONTakqrjnVA41O2ug+/Rpf/JHhyw8p+TUc/MIKQ=;
	b=fcE3tcuN+y61TOKq5H4y9cqYEYbENPq8lw6L7mxeps8zmDjWuSBlTHA2Dv2FFdzbRADLIu
	IXFrM2wcaKVDEzWHMQ5frGh/r9zmFT4VXUjbUF3IvgYm/ByUPLGQS+6mQcsnUIlEAG72lK
	jL/pFwQMC9wymNau8/d1y9Vz816c5Ow=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-BVIDFCZfNxqrhUAmbp1BAg-1; Wed,
 21 Jan 2026 12:53:09 -0500
X-MC-Unique: BVIDFCZfNxqrhUAmbp1BAg-1
X-Mimecast-MFC-AGG-ID: BVIDFCZfNxqrhUAmbp1BAg_1769017988
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47F8719560A7;
	Wed, 21 Jan 2026 17:53:08 +0000 (UTC)
Received: from fedora (unknown [10.22.80.67])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA6E619560AB;
	Wed, 21 Jan 2026 17:53:05 +0000 (UTC)
Date: Wed, 21 Jan 2026 14:53:03 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:RUNTIME VERIFICATION (RV)" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 18/26] rv/rvgen: add fill_tracepoint_args_skel stub to
 ltl2k
Message-ID: <aXESFlL56FA0PyTZ@fedora>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-19-wander@redhat.com>
 <1f168ff5ffb531570fd83e3f398380e8df053275.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f168ff5ffb531570fd83e3f398380e8df053275.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Jan 21, 2026 at 02:57:02PM +0100, Gabriele Monaco wrote:
> On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> > The ltl2k class inherits from Monitor which requires subclasses to
> > implement fill_tracepoint_args_skel(). However, the ltl2k template
> > uses hardcoded tracepoint arguments rather than the placeholders that
> > this method would fill. The base class fill_trace_h() method calls
> > fill_tracepoint_args_skel() unconditionally, which was exposed when
> > the @not_implemented decorator was introduced.
> > 
> > Add a stub implementation that returns an empty string. Since the
> > ltl2k trace.h template does not contain the placeholder strings that
> > would be replaced, the empty return value has no effect on the
> > generated output while satisfying the base class interface contract.
> > 
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> 
> Mmh, this is a bit fishy though.
> We the patch using the decorator seems fine, but highlights how this method
> isn't meant to be in Monitor if not all monitors use it..
> Adding a stub here is just sweeping dust under the carpet.
> 
> Here should probably keep the common part of fill_trace_h() in Monitor (e.g.
> replacing MODEL_NAME and other common things) and create specific
> implementations in dot2k and ltl2k for what is not common while calling the
> super() counterpart for the rest.
> 
> Does it make sense to you?
> 

Yes, that is exactly my idea. Since the patch series were getting too
long and my brain too rot, I thought would be better addressing this in
a following up patch series. But I can work in the next version if you
are not ok with that approach.

> Thanks,
> Gabriele
> 
> > ---
> >  tools/verification/rvgen/rvgen/ltl2k.py | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/verification/rvgen/rvgen/ltl2k.py
> > b/tools/verification/rvgen/rvgen/ltl2k.py
> > index 94dc64af1716d..f1eafc16c754b 100644
> > --- a/tools/verification/rvgen/rvgen/ltl2k.py
> > +++ b/tools/verification/rvgen/rvgen/ltl2k.py
> > @@ -257,6 +257,9 @@ class ltl2k(generator.Monitor):
> >  
> >          return '\n'.join(buf)
> >  
> > +    def fill_tracepoint_args_skel(self, tp_type) -> str:
> > +        return ""
> > +
> >      def fill_monitor_class_type(self):
> >          return "LTL_MON_EVENTS_ID"
> >  
> 

