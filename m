Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DEB2DCC03
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Jan 2026 17:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769018176; cv=none; b=eaJCCFn5Fa3LBW3W87L2oeSsi0XpKLvl5fyDQ2SpMAt673fejitSN2jNpHVaMCsdUQ06vmCXJT8kXSuIdk/Ce2pb1WGURqsJ0nfukvMq1jOkgOxkMJ2UDx8NTEbkesGfkN8uMNeMENRK2bsExdZ7Be3hKN4Qjt4OOfh7iKKrMGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769018176; c=relaxed/simple;
	bh=f1iYBQ4zCH+lwJsoTcnzwdSzS3bE5leIR3uOVuRusZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3hsAK45YZDYwlxPagWo7yKCHCgTMPaDmEUltuoAvgrfqNtJNX2g7f0o5iMyc6zVctGLVobXei//UsrHaqssI068oyGb2UiGyqqOZ3sl85563jnfYjIZ+t8NA4NHJKG3nYNdgLigGXvsbsOmBmCa/Yffz7oEq/RGoym6IGIlMjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hy0YR7iI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hy0YR7iI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769018172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NRrn1z8YcaPdI1ZfVxcZ8YSSsZXSQOu3Wy4m46eV5xE=;
	b=Hy0YR7iIRIJBb72poi3o2jxo8TVHsdpYjmfIKb75tegsbwSqAUk46+EKQC1uNXLB/ikg/r
	hOvnziM6DfiZVAB7eYFpcI2XYq6H1h9daSVlpeE1n+lGf1KHWbQ8gGIwBnCJhOnzI4j6Bv
	qgr7glNvI9qFnc5F/by1jEEZ1+Go92Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-yMIazIt6OiqCYWY9Ou6O9w-1; Wed,
 21 Jan 2026 12:56:08 -0500
X-MC-Unique: yMIazIt6OiqCYWY9Ou6O9w-1
X-Mimecast-MFC-AGG-ID: yMIazIt6OiqCYWY9Ou6O9w_1769018167
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 879201800350;
	Wed, 21 Jan 2026 17:56:07 +0000 (UTC)
Received: from fedora (unknown [10.22.80.67])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F23973001DBD;
	Wed, 21 Jan 2026 17:56:04 +0000 (UTC)
Date: Wed, 21 Jan 2026 14:56:02 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:RUNTIME VERIFICATION (RV)" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 19/26] rv/rvgen: add abstract method stubs to Container
 class
Message-ID: <aXETCaCUjI_lVEDD@fedora>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-20-wander@redhat.com>
 <69298b5dcfda02051c5c1fe995efc333f980664f.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69298b5dcfda02051c5c1fe995efc333f980664f.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Jan 21, 2026 at 02:59:09PM +0100, Gabriele Monaco wrote:
> On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> > The Container class extends RVGenerator but was missing implementations
> > for several abstract methods decorated with @not_implemented in the base
> > class. This could lead to NotImplementedError exceptions if code paths
> > attempt to call these methods on Container instances.
> > 
> > Add empty-string returning stub implementations for
> > fill_tracepoint_handlers_skel,
> > fill_tracepoint_attach_probe, fill_tracepoint_detach_helper, and
> > fill_monitor_class_type. These empty returns are semantically correct
> > since Container is a grouping mechanism for organizing monitors, not an
> > actual monitor that generates tracepoint-specific C code.
> > 
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > ---
> 
> Just like the previous patch, the NotImplementedError here highlights a weakness
> in the design we should improve instead of cover.
> If all those fillers don't make sense for containers, we should instead move
> them to Monitor and leave RVGenerator alone.
> 

Yes, I agree. The design has a separate of concerns problem. The
previous comment apply here as well.

> Thanks,
> Gabriele
> 
> >  tools/verification/rvgen/rvgen/container.py | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/tools/verification/rvgen/rvgen/container.py
> > b/tools/verification/rvgen/rvgen/container.py
> > index 51f188530b4dd..65df21dfd17b2 100644
> > --- a/tools/verification/rvgen/rvgen/container.py
> > +++ b/tools/verification/rvgen/rvgen/container.py
> > @@ -30,3 +30,15 @@ class Container(generator.RVGenerator):
> >                               self._kconfig_marker(), container_marker)
> >              return result
> >          return result + container_marker
> > +
> > +    def fill_tracepoint_handlers_skel(self) -> str:
> > +        return ""
> > +
> > +    def fill_tracepoint_attach_probe(self) -> str:
> > +        return ""
> > +
> > +    def fill_tracepoint_detach_helper(self) -> str:
> > +        return ""
> > +
> > +    def fill_monitor_class_type(self) -> str:
> > +        return ""
> 

