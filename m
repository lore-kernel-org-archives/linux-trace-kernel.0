Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0327F3537D4
	for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Apr 2026 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775996339; cv=pass; b=U/RMni18bOFSnKX+m5MSoWTcq6CHbNeaW8fJgblmcdixW24txwBGCw9fMMtxgMXh0Vhay1a0HDHBtY8Y30UeyQE8rcm2d+kdrm99FVaEm3KXXvjJ8WnZGtW4mVs0IsTY0ENf1Po5jfha0tTQZcB6QrrgKmgX4W9dHwz/JqwfsPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775996339; c=relaxed/simple;
	bh=uafX2bQpJrLfg9yfw+DCfmB3m9g7ysXsoTFfZ75pRt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqQGCRGoRGgCSxhz6pwGRi8ACV/OwT/1tqc0uVh1/QlFS5EC9lsHgm77YAz2NLORopy0scPjMKHxdEscYxmKglcLuMmUBZaexs5aaXtSnISxTTQ4Y6qMeb76pQslxrhDPDhIBtEluj88+QFyW+sBxmRQ34DGD2OGI6uykHG5QjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1w7iWpP; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1w7iWpP"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-651c366f7efso185842d50.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Apr 2026 05:18:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775996337; cv=none;
        d=google.com; s=arc-20240605;
        b=j9Ol+dFEgq9jHUvqoybtLHyTMuXXSCL7+hixBcqlYBEE31PuYGL1Nc0uu60Ribhu1I
         KPR9Rh+rVRLFGwdQZ34wk3IMzop9rophr2cmMiWAByisNi9CArNPwtgV4FvNQwpt4Xv2
         MV0GH0tYr26MkmM6s4qQvyryS0sw1S1EfmeHbY818qSE2nJ4X/aFkG6uQGNsWUJUTlId
         AElxtGmoyqjuV0oPZT066NsVNG4B/01+doSjh0bz+D2nW8USclkk2ovnWiPGxCnzONvX
         oyaEiUzNqkT+I7fjxw+OA76JJEMExcU6xOGS0nQB4gR52K4ynQAJ0M2DWKKCUg9xRdTM
         hjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pDCtYpSt5MQDUqGRaPZuhMEbLqOBYANHADybtg+qQXY=;
        fh=PisLT4rnkpmhGYGU+NWER1fw3k0qWq4KxkLXQaGaRD4=;
        b=hoQDJEZG3jt7mvQkOMfVcWCX7GIw/XEoA3AJh+AQlJkNPYtBugyYzB5yqyNAyljXiB
         LM2IrpJ6NXiNNcdrNipetmrj5x5fJbOPDb/qqReVn81C8d+I3y7i/74BpdnN2LmIFCjr
         lXjL1nuyclmzdgRCZ87xUkNPqMa/9b4jTLyps9HrSFkTzYrxeWZR5VsGhZGz2Zk33SNF
         8AZ8dghLLYU68Nn2ksXakdVi31vPCE4BQcyxAOW4f8P0t3l4U4epvkWnPx+9pMDi57A3
         NSTAQchLsj3ooWlaBh+DU2rf7wfq4DJ2c+M3vtUKQs2f/egY/9/PRjBEz3jpqiJKjcFV
         PJDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775996337; x=1776601137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDCtYpSt5MQDUqGRaPZuhMEbLqOBYANHADybtg+qQXY=;
        b=L1w7iWpPjeegHoc9cP6BaGEAqFGK/8eCGY7df9Mu6T7TiPe6jg8yrlfT5j7X6WhBZS
         JCZf2TZlC/ol2ltgkb2jLz+ZBfnaddtYmm7F2xg9ysRtaKPYEIIj6Kc3fMIWXVRQhfS/
         Rv0lcdIXCgI16EFL0Z8jQJqxDECvrtcyPN0s9S5J4Q9Ac2X/MxNBac78S1FhVR1+aDbn
         mKfrDac9sl7Lf8IZ8AxVCoHAyODdkNQMhgvyOhwOlgaUNvf871kGs/tzQ9Y5Q99GPL7T
         roUWoyD+oGDJmTDhegrO0nRZOlBkMQKlLi8EulyjkxfBm0psBw1b1Xa7X+laho44JjdZ
         +Kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775996337; x=1776601137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pDCtYpSt5MQDUqGRaPZuhMEbLqOBYANHADybtg+qQXY=;
        b=E5Urg1IfEjdn0oYOqgyhLHn4r/clatjrd5tS2qbynyANfSDPXVyWh3OHyKLO1iMap3
         3BherpB6+NSnNilhyFeCOLrYYd1gKMFr7hi810cWujQL6SXZg+GOH6pzZAVQuHHLZ/BB
         3x7gPYgN8XJv6sTEM9pspOAIWb2c81qGRAgcpWvrwCOJoxxOZf/tG4BF7DPFcioqEIIx
         hdm+fyuNCzOlYiWKvi19hEtNX+dOEx+ISPZ1n6JNzbo1yKjkvmkDYp6q5VyTU+DrPsDt
         nBdKgeh6axWclU53fcWudqFIpvIKZiAfOenagNBXlwzgdqutibsqq8ErGCbuGD3ZlVss
         SlFg==
X-Forwarded-Encrypted: i=1; AFNElJ++9u/cVxP4fOQlWRUjMkA1kBONNhRYsFqcLyiNOF4R1E6SXVMWTfH1GqQQxCW6jdOOr334gdYiV5CXkCbtO5uMq2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZGjTSLGUIMIQxyXZt3illtL0EQypc+rUA7/lqqJ1HjGkwDK6I
	juI6L9X/bAKkINnH9YG2CrQrLpA8oD9vjCjIvRCHFNESxHh50AcoxG9njD0yxEoHqJrCA7C0yaS
	9SRPh9VfSSk3dnDol7WBUSeOMWfuG9KA=
X-Gm-Gg: AeBDievP9NihPX/mxuDNrcjfyH7AWAqTH3Hn+7+NybrbJ2OcMGxMfZ2kj7HQLsv3J2g
	AiklV043tGiaB+nYb5q1YOgEBGRC8+D363XbWb99DUCmCPj7IxqlXVEhacAIPIzP9lRDZp4bOek
	XMzBeKKSKyEyt4v/LJ04LBHhZRwPwszQSzltF0v6b0CLeB4irfW7ab6fGFh9ZQiU2X8C6RqfLUU
	AbGt29eSNV8rILEQ4bL7r8C669XqM5tsXPO53OONCS7V7X9GxsTNra1TynnnsW/DX3/OJM34b9l
	rhSl808PRS8b/Y+QzxmGSZ381H/v4kxbjxQHzLZP
X-Received: by 2002:a05:690e:e8b:b0:650:70da:bc25 with SMTP id
 956f58d0204a3-65198c71a1amr8599414d50.58.1775996337015; Sun, 12 Apr 2026
 05:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALOAHbCbcw2jpjk9JD9yyf+SMpQ-s9FAonSaz7Gs4XUeP+w+2g@mail.gmail.com>
 <CAPhsuW4B00-grg9XJa+AO3xgGwM_u8FC+GH3JrkYZOJx4PuV8Q@mail.gmail.com>
 <adQhpBC2W9I6QW-g@redhat.com> <CAPhsuW66tuF+QZ0pVheWb5sC4NQ-9CXikq=zMrPBXTHcsVPjdg@mail.gmail.com>
 <CALOAHbDN_t-ZRO0g9_sQFCv0J6SPDFfwJCcwSzd4ww5XRkU0QA@mail.gmail.com>
 <CALOAHbCxPA0dtsx7L2kYn8wwBdM=krZyOpfRTBiDW9qfA_zmzQ@mail.gmail.com>
 <adUd0Mojbtrwmeod@pathway.suse.cz> <CALOAHbDG9mq1iJv5suct=cqJ+2r8VvJ-dXN=nuvMw0XYqnUjxA@mail.gmail.com>
 <adY_WgA54CDtWBq6@pathway.suse.cz> <CAPhsuW42WqGuZ1Z-RG0yzifZ7rh=XKUa5hKb6JxLeTWdc4s4-A@mail.gmail.com>
 <addW_-whBavyHY-Z@pathway.suse.cz>
In-Reply-To: <addW_-whBavyHY-Z@pathway.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 12 Apr 2026 20:18:21 +0800
X-Gm-Features: AQROBzAAbQj2joTRPhJ-lyVJz17Ih4lLYbyXLH4mJVa2clLa9rohXScgqMMq5Wg
Message-ID: <CALOAHbB-b6YUx4zQjp-AgV0gYp26pKjwrjABd8+XJHNsW=0EtQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] livepatch: Add "replaceable" attribute to klp_patch
To: Petr Mladek <pmladek@suse.com>
Cc: Song Liu <song@kernel.org>, Joe Lawrence <joe.lawrence@redhat.com>, 
	Dylan Hatch <dylanbhatch@google.com>, jpoimboe@kernel.org, jikos@kernel.org, 
	mbenes@suse.cz, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, kpsingh@kernel.org, mattbobrowski@google.com, 
	jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 3:36=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Wed 2026-04-08 11:19:50, Song Liu wrote:
> > On Wed, Apr 8, 2026 at 4:43=E2=80=AFAM Petr Mladek <pmladek@suse.com> w=
rote:
> > [...]
> > > > >
> > > > > This is weird semantic. Which livepatch tag would be allowed to
> > > > > supersede it, please?
> > > > >
> > > > > Do we still need this category?
> > > >
> > > > It can be superseded by any livepatch that has a non-zero tag set.
> > >
> > > And this exactly the weird thing.
> > >
> > > A patch with the .replace flag set is supposed to obsolete all alread=
y
> > > installed livepatches. It means that it should provide all existing
> > > fixes and features.
> > >
> > > Now, we want to introduce a replace flag/set which would allow to
> > > replace/obsolete only the livepatch with the same tag/set number.
> > > And we want to prevent conflicts by making sure that livepatches with
> > > different tag/set number will never livepatch the same function.
> > >
> > > Obviously, livepatches with different tag/set number could not
> > > obsolete the same no-replace livepatch. They would need to livepatch
> > > the same functions touched by the no-replace livepatch and would
> > > conflict.
> > >
> > > So, I suggest to remove the no-replace mode completely. It should
> > > not be needed. A livepatch which should be installed in parallel
> > > will simply use another unique tag/set number.
> >
> > I think I see your point now. Existing code works as:
> > - replace=3Dfalse doesn't replace anything
> > - replace=3Dtrue replaces everything
> >
> > If we assume false=3D0 and true=3D1, it is technically possible to defi=
ne:
> > - replace_set=3D0 doesn't replace anything
> > - replace_set=3D1 replaces everything
> > - replace_set=3D2+ only replace the same replace_set
>
> Yes. This well describes my point.
>
> > This is probably a little too complicated.
> >
> > > > This ensures backward compatibility: while a non-atomic-replace
> > > > livepatch can be superseded by an atomic-replace one, the reverse i=
s
> > > > not permitted=E2=80=94an atomic-replace livepatch cannot be superse=
ded by a
> > > > non-atomic one.
> > >
> > > IMHO, the backward compatibility would just create complexity and mes=
s
> > > in this case.
> >
> > Given that livepatch is for expert users, I think we can make this work
> > without backward compatibility. But breaking compatibility is always no=
t
> > preferred.
>
> I believe that it is acceptable because:
>
>   1. It was always hard to combine no-replace and replace livepatches.
>      I wonder if anyone combines them at all.

Because 'replace' patches can supersede 'no-replace' ones, users have
to maintain a strict loading order. I doubt anyone actually combines
them in production.

>
>   2. I believe that nobody tries to load the same livepatch module on
>      different kernel versions. Instead, everyone prepares a custom
>      livepatch module for each livepatched kernel version/release.

Correct. We always build and apply distinct livepatches for each
specific kernel version.

>
>      And the tooling for creating livepatches will need to be updated
>      to use "number" instead of "true/false" anyway.
>
> That said, it is easier to always use "0" for non-replace patches
> instead of assigning an unique "number" to avoid replacing. But
> I do not think that this would justify the complexity of having
> different semantic for 0, 1, and 2+ replace_set numbers.

Fair enough. Let's drop backward compatibility to keep the
implementation simple.

--
Regards
Yafang
