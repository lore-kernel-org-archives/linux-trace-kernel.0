Received: from out-182.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1702344605E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Aug 2026 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459572; cv=none; b=l80iu+XgXbqcLrQyuRAuYR5vg4hxb74UXvfcaPDvVdeyNiVNRUEUdfjo58bLvtKpbzURIsI5tEJJ3uuQuNb+hJMbj4RGDUoxwzY00Ow33z38qJJLBysNxzCxiDpWS0+6qHDc8nTU+q1RrzXuid5gbUi/IeaHxW91MzGX93H1cvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459572; c=relaxed/simple;
	bh=Bd+Bl/a3Plzw7PzGw0HfdsccKH/tRTwcysEidL485Qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEbT8CrqfC0bAlXOn7l5FSH51gCtQxfMctUotv+SC0Teq6NIXVXYK2G6BFc7GKD6be8ZZA7jD4IpLLDzXRfAQUB73P5G6PZWopS5Ncd2fEu5KyS3h7PWyLS3u+dEJ4KEt8KxEOjportheXle1Qbodk5u2r545T9BcAPVeeVuX+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xnUMFvTQ; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xnUMFvTQ"
X-Forwarded-Encrypted: i=1; AHgh+RozIIfHm15YALP/F1APtiYxCuN3rHtNVS/sE5ZKwl+LAFeK87lNgREDi3QldGCB1oVraxOdjbxutA7aZuDDtP7vRjY=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786459569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bkBsw0nlNKffF346uy8TG9H988zPUKGCrYeJMzVpF88=;
	b=xnUMFvTQbVNoPfYp8bxmo5hxg596VKD7z3qIBObB3kRcvjzZ/HId2kcCpJs4kHTxQV8PKE
	qusgGTpSaiaievVI8sUGPsPuN1iWgfS2P7+dgjJqWAgx7qjn2vEL4y0D8Nh/pXgIcS2Jq2
	ceefOmaaP/sTIRT+M4MFM+4AAlLzeCo=
X-Gm-Message-State: AOJu0YxKyCotdWw8iTiJijf0HVcT8VdnuCtbsvzNh99bAntRyAO51fXX
	xH6qja9o97xNtEs1Pt6IZXA+SdcZNGxpKTLPXlyorggK0rWw0Es+Yx/DIYE+5X/i8Y6/8P2weNT
	rdXcOIyXTph6OOseKs4qo7cSJJsPlA7Foa0lfODWs
X-Received: by 2002:ac8:7fc5:0:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-52d5805b682mr10634971cf.1.1786459525915; Tue, 11 Aug 2026
 07:45:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804112317.1937387-1-fuad.tabba@linux.dev>
 <20260804112317.1937387-2-fuad.tabba@linux.dev> <20260810183017.32db8b80@gandalf.local.home>
In-Reply-To: <20260810183017.32db8b80@gandalf.local.home>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 11 Aug 2026 16:44:48 +0200
X-Gmail-Original-Message-ID: <CA+EHjTxge9X+XyNPpJwrpK5wiO4cHRHJrCPMPgo0iZBXHSLPxQ@mail.gmail.com>
X-Gm-Features: AUfX_mxjTGmsQJDiPjF8-9rvIAUMM_O2scFaxYRWXLqNn62taG1aJ6Vh3ON23CE
Message-ID: <CA+EHjTxge9X+XyNPpJwrpK5wiO4cHRHJrCPMPgo0iZBXHSLPxQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] tracing: Include linux/types.h in trace_remote_event.h
To: Steven Rostedt <rostedt@goodmis.org>
Cc: maz@kernel.org, oupton@kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, catalin.marinas@arm.com, will@kernel.org, 
	mhiramat@kernel.org, alexandru.elisei@arm.com, vdonnefort@google.com, 
	joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, qperret@google.com, ardb@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

Hi Steve,

On Tue, 11 Aug 2026 at 00:30, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue,  4 Aug 2026 12:23:07 +0100
> Fuad Tabba <fuad.tabba@linux.dev> wrote:
>
> > trace_remote_event.h uses bool without including linux/types.h, so a
> > translation unit that includes it ahead of anything else that pulls
> > types.h in fails to build, as with nvhe/trace.h at EL2.
> >
> > Fixes: 072529158e60 ("tracing: Add events to trace remotes")
>
> Is there a config that already fails the build without this change? Or is
> it that new code will fail without it?
>
> If it is the former, please drop the fixes tag, as nothing is currently
> broken. If it is the latter, then sure, keep it, but you should mention
> what config options break with it.

I checked the include graph and tested by building with configurations
that could potentially fail. Nothing does. I dropped the fixes tag in
the branch I have based on kvmarm/next in case Oliver/Marc want to go
that route [1], or I'll respin it on the latest tag once kvmarm/next
has gone in to the next tag.

Cheers,
/fuad

[1] https://android-kvm.googlesource.com/linux/+/refs/heads/tabba/pkvm-hostva-kvmarm-next




>
> -- Steve
>
>
> > Acked-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
> > ---
> >  include/linux/trace_remote_event.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/include/linux/trace_remote_event.h b/include/linux/trace_remote_event.h
> > index c8ae1e1f5e721..e4cc2d4497bcf 100644
> > --- a/include/linux/trace_remote_event.h
> > +++ b/include/linux/trace_remote_event.h
> > @@ -3,6 +3,8 @@
> >  #ifndef _LINUX_TRACE_REMOTE_EVENTS_H
> >  #define _LINUX_TRACE_REMOTE_EVENTS_H
> >
> > +#include <linux/types.h>
> > +
> >  struct trace_remote;
> >  struct trace_event_fields;
> >  struct trace_seq;
>
