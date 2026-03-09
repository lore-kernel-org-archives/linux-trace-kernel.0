Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7E7392809
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Mar 2026 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074802; cv=none; b=KF60WOYExyctgSQekc+/6Is6zYqzgDhwqyM75Tfy8+Kwoc1riOOTTluf0Rd1rdf83h5lns1/td8VKeLjLk8YyaqI/pKH1JHwdXTAW0DTcFM4CucGg0MG0vf99XEPKdtOVQrpnR4YTXgGLGNDGErw4ENQ94Et2d95uNEqZPxSyQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074802; c=relaxed/simple;
	bh=uuvhfg2qnqbkgNr9KNXQuucpIZWJRHTU2GeAY0lvEUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dRlZFqh+/1IbQsHeQ6q1X9lO5kBIlyRXnPldvr813bTVR6ry4ppVBk0T9rSVENRvmOs/FXUHCCrUsjFT/tZjxC910LjE0+7W005ugT22wOG2dPCV9oD44nZVUo/2pFoR2a47PEyNu1klNsBrOCF1siDbQiMMr2uaA+CSXrJmHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3hiVxVT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3hiVxVT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773074799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qtS8ZO1ckKvSZkDwebktBaXg6VPIyAuOjxZZ8IlSru8=;
	b=X3hiVxVTTuYmUM+rXBD14BbKxBluNSPRepIWNpNURLDazfmLZ5vO64L7UMN2ydUooa+n9d
	WY5EGwXzPxxOBtBrLEKXtW5Kvqwl1GwKCd6DmsjQT+0dMTdf47XH35Bl8Gb318sS6CBwC6
	pzB0tUwDupCoQTyrfMaq6Yyin9wzXQ4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-KYJMRwg-NMOgwUeg7ekOSA-1; Mon,
 09 Mar 2026 12:46:34 -0400
X-MC-Unique: KYJMRwg-NMOgwUeg7ekOSA-1
X-Mimecast-MFC-AGG-ID: KYJMRwg-NMOgwUeg7ekOSA_1773074793
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E04518005B4;
	Mon,  9 Mar 2026 16:46:32 +0000 (UTC)
Received: from fedora (unknown [10.22.81.10])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC8181800361;
	Mon,  9 Mar 2026 16:46:26 +0000 (UTC)
Date: Mon, 9 Mar 2026 13:46:25 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Crystal Wood <crwood@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Haiyong Sun <sunhaiyong@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Daniel Wagner <dwagner@suse.de>, Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 16/18] rtla/trace: Fix I/O handling in
 save_trace_to_file()
Message-ID: <aa70ylF-FxHtzMJ_@fedora>
References: <20260115163650.118910-1-wander@redhat.com>
 <20260115163650.118910-17-wander@redhat.com>
 <CAP4=nvSBEgfJg8qFYakiSfhE-Cp3RF9OoT2NR2qO+oRk+1BGEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAP4=nvSBEgfJg8qFYakiSfhE-Cp3RF9OoT2NR2qO+oRk+1BGEg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: x_u2QIIvt8wUNHshCw1uXH6T_Nc4IbeGcmdWtg5-AhU_1773074793
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Mar 04, 2026 at 11:30:13AM +0100, Tomas Glozar wrote:
> čt 15. 1. 2026 v 18:29 odesílatel Wander Lairson Costa
> <wander@redhat.com> napsal:
> > diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
> > index fed3362527b08..8e93b48d33ef8 100644
> > --- a/tools/tracing/rtla/src/trace.c
> > +++ b/tools/tracing/rtla/src/trace.c
> > @@ -73,6 +73,7 @@ int save_trace_to_file(struct tracefs_instance *inst, const char *filename)
> >         char buffer[4096];
> >         int out_fd, in_fd;
> >         int retval = -1;
> > +       ssize_t n_read;
> >
> >         if (!inst || !filename)
> >                 return 0;
> > @@ -90,15 +91,30 @@ int save_trace_to_file(struct tracefs_instance *inst, const char *filename)
> >                 goto out_close_in;
> >         }
> >
> > -       do {
> > -               retval = read(in_fd, buffer, sizeof(buffer));
> > -               if (retval <= 0)
> > +       for (;;) {
> > +               n_read = read(in_fd, buffer, sizeof(buffer));
> > +               if (n_read < 0) {
> > +                       if (errno == EINTR)
> > +                               continue;
> > +                       err_msg("Error reading trace file: %s\n", strerror(errno));
> >                         goto out_close;
> > +               }
> > +               if (n_read == 0)
> > +                       break;
> >
> > -               retval = write(out_fd, buffer, retval);
> > -               if (retval < 0)
> > -                       goto out_close;
> > -       } while (retval > 0);
> > +               ssize_t n_written = 0;
> 
> Why break the style of declaring all variables at the beginning of the
> function? n_read, added in the same commit, keeps the style.
> 
> This also applies to the previous patch.

In this case `n_written` is harmless and I see no problem in moving it to the
beginning of the function.

For `written` and `w`, declaring them where they are right now brings the
benefit of making them const correct. If we move them to the top of the
function, we lose that. Since the kernel moved to gnu11, the C89 top-of-block
declarations are relaxed. Keeping them at the point of initialization minimizes
their scope and documents the intent. This helps avoid programmer mistakes.

However, I fail to follow my own advice more than I am willing to admit.

> 
> Tomas
> 

