Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3790B3ACA60
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 May 2026 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087847; cv=none; b=G5lfz6Vyb7lw+1X4jKPWWacf0P986utotGP2neyZtwQmvSKerCjASZEvG3LmfCi39zwzMbK/5A6DnLvIn3o/gPboilVA2kH69dZlo0J0m99GXQo3hWpVbDgtMp+Dy4YF9gtkMLxH/uqk7tSaq0uyR/Rej/bjko6hR2paUWkfKUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087847; c=relaxed/simple;
	bh=UoD68z0Bd1yc4sfrNZqLDPk4O1bJEAcKIWD4oka/VgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgIL/m61F46WxWWPoTEd4UKyHMCVIfpLZcxSM71rwQr03PXiGrG1+KPK+x+XzvZgELvyvptWWmQ9qq9gPn0SMPJ9w4PKHkpFbjfl5RDf6UXZ4bSv6/Z7qcmLL2WrffKHN5d0ffwIbI7FbG/6gXbu/9B/ltR16w/nUZNdOIdOt4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5EwU3oy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5EwU3oy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780087845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iFJyJWJYZjKkbr4u/Iw7dqAvQNwkZiT8Y43qNWAKD28=;
	b=g5EwU3oyrU0OWaZMrShq2FT2wCYgIZ4+OUvfyivHJMYHChw/g0G+xtBnX5YgInis+Wxaxk
	xnWjW9bHC8zQN3lVd6vkhrYcLboNITtN3celfS6efT+WUzhUStL3QD7qfXsJ/oQ9BVGe61
	BSvzoYc/6tVWn9O9mWQD15JE2stn0zM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-SINE3-DVNRy6tmhGaGQTQw-1; Fri, 29 May 2026 16:50:43 -0400
X-MC-Unique: SINE3-DVNRy6tmhGaGQTQw-1
X-Mimecast-MFC-AGG-ID: SINE3-DVNRy6tmhGaGQTQw_1780087843
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-bcbb3e56f10so285141766b.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 May 2026 13:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780087843; x=1780692643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iFJyJWJYZjKkbr4u/Iw7dqAvQNwkZiT8Y43qNWAKD28=;
        b=MvakO6W+XScsfaAq/nJ0v9Y5TCkD9bwzVN5FFcCbtTTEM55NZcC77QM1YB5XYK3GT8
         K9rgw/oU/JNLRTRZNdKRETdRzm4LytYmHEzptHthIIlv5MxbiGgxJzgM2mVK2nYBIA5A
         ukUBrBxdQmm5WVkI+0cTRlVzi7vpEbJc6fjIv6dxqhIgdYaDV/O2VsGrTFa5mA0gczcP
         G0wQyPb5NcEN5onilBDk9gCjyCyyU/ZzNcSN06F365KuOe9PZopekitJwuDRk5Qux0db
         cUTjYUTXfjHXH4K3wjJeLzciA8SBkd7iG3lFE6vLeVV4J1cFY8SGaXRxCuYhE1lmsDQa
         CZKw==
X-Forwarded-Encrypted: i=1; AFNElJ8kdO429YR/DP7xTL7GizX51cr+i/Qon7/sO4XIn0VgSLRA8O5PbQy8/1enXSIr81b5ZBXXkeatTPyKhqOeypw9YM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6XOAuh7UOmEqNTv9N4H79rA5yNoLXpGrFmQ58JTUbC9DiwMdS
	Jcn7UpW2FfuU/K8/SgjBoXjnF3HdZN0aSNZ1/uWOx4T0NqjWmo6aF2mkp2cXZduDbgDbDFDAp/X
	5G8cp0fdMcoL6d6R930aUNmhfQeU967YMB5yzxgwOP31Ds9txqY0Bx28u/Y+TkqSlhAFS2czGqL
	G0hxNOi9Ct1D3T3ZbN7xZCXgWzFBOuu37DQWk2LbwXRXN2I0UYaRA5dNJVOyI=
X-Gm-Gg: Acq92OGaoJ0QcCLhCGWPrPpnhwI5s5wH5/AJoTwPtqxpA2BT/OTnnShlQ7j5t9Dy9lu
	OQCQHYAmRsKAKzYvv9BJeqhlFR94pJI81MtPq9TUq1Cgmg7nCWPYgY4IZmY1xyMRGVN5HUv5i56
	T097svEvx+9Kevdqz04hVUGtNCE/Oke9Na+vhxtikxwq0rDX0T5PcOsdUPYbUN++1OGOe0KZBaW
	owJxnhgPg5gt0FWf2wEP9bS/JoE7+3+gBOk7R6OAZnLuxk=
X-Received: by 2002:a17:907:7f8d:b0:bdc:e6a6:a1a6 with SMTP id a640c23a62f3a-beab7cb64a8mr68184866b.48.1780087842630;
        Fri, 29 May 2026 13:50:42 -0700 (PDT)
X-Received: by 2002:a17:907:7f8d:b0:bdc:e6a6:a1a6 with SMTP id
 a640c23a62f3a-beab7cb64a8mr68183966b.48.1780087842231; Fri, 29 May 2026
 13:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529130643.3080315-1-tglozar@redhat.com> <20260529095646.73c95f60@fedora>
In-Reply-To: <20260529095646.73c95f60@fedora>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 29 May 2026 22:50:31 +0200
X-Gm-Features: AVHnY4J3tSJCqXoMh8_o8DQxzSn2KvJQMa0AE2Bx9oivhPRWRzwkutm_V47ikGg
Message-ID: <CAP4=nvSi2q=h308Osmrph4YgOkMJE_QmsfSAQcyvi8sxKY2kug@mail.gmail.com>
Subject: Re: [GIT PULL] RTLA changes for 7.2
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _rbRKSSM5DH99-kxjSm0jM2u1TG2EajpFyNTEw6S1II_1780087843
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 29. 5. 2026 v 15:57 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis=
.org> napsal:
>
> On Fri, 29 May 2026 15:06:43 +0200
> Tomas Glozar <tglozar@redhat.com> wrote:
>
> > - Fix discrepancy in --dump-tasks option
> >
> > Due to a mistake, rtla-timerlat-hist used the CLI syntax "--dump-task"
> > instead of the documented "--dump-tasks". Change the option to match
> > both documentation and the other timerlat tool, rtla-timerlat-top.
>
> Is there any concern that scripts might be using the old option?

Good point, I'm not aware of any, but it is possible.

>
> I wonder if you should keep the old option for backward compatibility,
> but do not document that it exists.
>

I did not originally plan on keeping the old option - and the commit
does not keep it - but since libsubcmd allows match on prefixes in
general, it actually works in the tag:

$ ./rtla timerlat hist --help --dump-tasks

Usage: rtla timerlat hist [<options>] [-h|--help]
       --dump-tasks      prints the task running on all CPUs if stop
conditions are met (depends on !--no-aa)

$ sudo ./rtla timerlat hist -c 0 -T 1 --dump-task
# RTLA timerlat histogram
# Time unit is microseconds (us)
# Duration:   0 00:00:01
...
Printing CPU tasks:
   [000]              timerlatu/0:66862
   [001]                         :0
   [002]                         :0
   [003]                         :0
   [004]                         :0
   [005]                         :0
   [006]                   auditd:1000
   [007]                         :0
   [008]                         :0
   [009]                         :0
   [010]                         :0
   [011]                         :0
   [012]                         :0
   [013]                         :0

The only build where it does not work would be in the middle of the
pull request, with the --dump-tasks fix but without the libsubcmd
migration patchset.

Anyway, thanks for the feedback.

Tomas

