Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B242D3A86
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Feb 2026 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770322377; cv=none; b=Grf4tzDftPGN9C9z2fDZkbe5lUcyOHiEVZIkh7wwS442SzOOXUF00jYA+c2w0n3N0m9IotOtYzTVRWGS6R9xMclfgG1ej5XSK094Np/TceHCJut8LuUKUMIYbs7qcKYakZJ2DB5MPvOfGl8aEExNBAoAV5lcVnIHfP60+NHkZfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770322377; c=relaxed/simple;
	bh=zaSr4rE/b4mSN8VSFCqwSqU06aPztKzd318tvbOjbgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hT//G+jSdUfjOoVnPhGD31QiOWxosanU4FNxkf+XlxPXEgM/XolVZOGyrKW6DzqWxh6bpe16GteD/1ZubTDLIppvnTilDW4VE0A76/uaW3+mulwT5r4oupFDibNEQv5i26vvpWxbflHl7pfgKtidOus3ieF29SE8n/IJeT9piyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ABP+bVAf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABP+bVAf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770322376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+WX1j6Y6/swuH4pxbow/FdPp1yCIK87zFtS4D5BRnw=;
	b=ABP+bVAfX/RDxDGg/272uazvB/VFQ4ZIOh3TQlIsUBNi/VwDazQU7oM+97MQC7HrQDjsKc
	8uFVUYNKV4IHJrV+v6bI1078tf7hY2nwHpZReDDQ9uQRwLnpcdZ1d0fJpAEFwQp3H31Nx7
	mdkoWJzVvQbtlRKgu6tN7MBMTLM9GeE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-_3AuwUYLPWukmM2zWzfxqA-1; Thu,
 05 Feb 2026 15:12:53 -0500
X-MC-Unique: _3AuwUYLPWukmM2zWzfxqA-1
X-Mimecast-MFC-AGG-ID: _3AuwUYLPWukmM2zWzfxqA_1770322367
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D5901800630;
	Thu,  5 Feb 2026 20:12:47 +0000 (UTC)
Received: from fedora (unknown [10.22.64.136])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DDAD8300DDA5;
	Thu,  5 Feb 2026 20:12:44 +0000 (UTC)
Date: Thu, 5 Feb 2026 17:12:43 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	"open list:RUNTIME VERIFICATION (RV)" <linux-trace-kernel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 20/20] rv/rvgen: add missing return type annotations
Message-ID: <aYT4I9shfAZOkpal@fedora>
References: <20260204144914.104028-1-wander@redhat.com>
 <20260204144914.104028-21-wander@redhat.com>
 <1edfc4451310645ffe89a60e461682eb49ff6006.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1edfc4451310645ffe89a60e461682eb49ff6006.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: FA7-YVaTFmrJoI2ufKR52jZDgeUgRV8rw2Onib4Pt_Y_1770322367
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Feb 05, 2026 at 08:24:40AM +0100, Gabriele Monaco wrote:
> On Wed, 2026-02-04 at 11:42 -0300, Wander Lairson Costa wrote:
> > Add missing `-> str` return type annotations to code generation
> > methods in RVGenerator. These methods return strings, and the missing
> > hints caused errors with static analysis tools.
> > 
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > ---
> >  tools/verification/rvgen/rvgen/generator.py | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/verification/rvgen/rvgen/generator.py
> > b/tools/verification/rvgen/rvgen/generator.py
> > index ef6c9150f50c6..4b984869a7b3d 100644
> > --- a/tools/verification/rvgen/rvgen/generator.py
> > +++ b/tools/verification/rvgen/rvgen/generator.py
> > @@ -73,13 +73,13 @@ class RVGenerator:
> >              return f"#include <monitors/{self.parent}/{self.parent}.h>\n"
> >          return ""
> >  
> > -    def fill_tracepoint_handlers_skel(self):
> > +    def fill_tracepoint_handlers_skel(self) -> str:
> >          return "NotImplemented"
> 
> Those are the ones that will raise an exception in a later iteration of this,
> right? I wonder if we really need to touch them now.
> Anyway I'm fine with this if it pleases your tools, thanks.

I was uncertain if I should send now or postpone it, to be fair.

> 
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> 
> >  
> > -    def fill_tracepoint_attach_probe(self):
> > +    def fill_tracepoint_attach_probe(self) -> str:
> >          return "NotImplemented"
> >  
> > -    def fill_tracepoint_detach_helper(self):
> > +    def fill_tracepoint_detach_helper(self) -> str:
> >          return "NotImplemented"
> >  
> >      def fill_main_c(self):
> > @@ -100,19 +100,19 @@ class RVGenerator:
> >  
> >          return main_c
> >  
> > -    def fill_model_h(self):
> > +    def fill_model_h(self) -> str:
> >          return "NotImplemented"
> >  
> > -    def fill_monitor_class_type(self):
> > +    def fill_monitor_class_type(self) -> str:
> >          return "NotImplemented"
> >  
> > -    def fill_monitor_class(self):
> > +    def fill_monitor_class(self) -> str:
> >          return "NotImplemented"
> >  
> > -    def fill_tracepoint_args_skel(self, tp_type):
> > +    def fill_tracepoint_args_skel(self, tp_type) -> str:
> >          return "NotImplemented"
> >  
> > -    def fill_monitor_deps(self):
> > +    def fill_monitor_deps(self) -> str:
> >          buff = []
> >          buff.append("	# XXX: add dependencies if there")
> >          if self.parent:
> 

