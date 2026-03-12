Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9035D38B7CB
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773305917; cv=pass; b=sknBbMEg4EHFzqbP365w0WbhbaWacNfLpwCgDte+2ihW6B2bD/GiYDYyjDYxnj5pHMR8WoWxaeDianGncRmRigAmpRAHlihOG7NH8HM2ihjr0nkm7CjwHdaAwAq0xPm2317g8E74ibBV36rVlt5wqCBlz8mt48N/Ve9BCstpObI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773305917; c=relaxed/simple;
	bh=lvKkcyZd8G7e8ZicmAHZx0gDBEp6+O25joc2hW20ZtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMK6ikwnp21OJs5gaXLz6NDbwzWJ+g++6xWAS2omc9hjMgkAO82rgjkLWDjHHRTkt33rTsS1HzqNjJxcU7Q4e9i6y8jhuaRkxfSsnDWJJfq8vslVG6nIlRRif2uOV+is/yDZjSOO4wQFkgqlNKGvtT3oijHXV5J+TDPUuhpqDfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMZxUd2o; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMZxUd2o"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7985ce90542so7898907b3.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 01:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773305916; cv=none;
        d=google.com; s=arc-20240605;
        b=NxDlZqcNz+H1Ob/+eCa6HV+y1hK2kFCL07fiwMo6pb5QSUugM0ljbHoTvqGjfqw+Dd
         KCoxfEb3owALk8GYlC29fNhdZjoqpr6qXhtJhtVclNIvD+XU6ZXG0YuEFFHJwKD7oB5k
         S2hGK36DEgfFHlqK2cldHSg/55+EFtnCPLayqFadHG0P9mD6CtJdaRrCvNJwp1WbTN93
         Tr3SRrmHJtT/Inz0sytgIvM+hThV4Kp7TY+2aPShQao+klcoAuv8EJykyboAJ9iHhOyQ
         Ego3oDT5CrLvL5iiQGMOS1Ng4ddHhuk6jrBWZ88SLu26dB50vZeg94k7NIlDv66oSPER
         Fmjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lvKkcyZd8G7e8ZicmAHZx0gDBEp6+O25joc2hW20ZtM=;
        fh=qPBXhxXLha4BmGZ7zCiX/acnOuZFFOibO0oqlphkp4Y=;
        b=YwDW8qevItVb+xDbgP3kx5OlNRNCopfGb/YI/b//0M/o63GNKNxfh/bnlbgLp00wbE
         VbJNTcC+3KKHMKVh033xr740PYcpUFhRYFx9MuQF9WGmq9ivsdHHuHIKLLzm3++rDpkI
         iy3D3EKY4ZVRFjkdCRi95YFIqa8ri2r7Lv48ukc83lVF3JvrN7R0yLGJ0VtcJzk4U0wK
         h2SqVMup7kbcP6khzdVgE1syZc1aoKlwssrnbwz1azRQWbXynX+FP7JLHzsR5ujXjeYj
         /lWf2ZRokxlsZxnBdrAcKxQVX/ISvhviV8Ync/R5n3UXj1YpXHp0xAbIU4K752GPW1m7
         B4sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773305916; x=1773910716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvKkcyZd8G7e8ZicmAHZx0gDBEp6+O25joc2hW20ZtM=;
        b=dMZxUd2o16J0jCN44FrwpI1kMalVcJuXZKeVuEJA6yHxMlsLLEpKF7x8jBg4gZ/cli
         3NWrm36Zgeap5hXy8RgsLH9E2L3cwU3WTE2MrZvgMb6/svbds/zpBr/ih+EdDUx+NNH5
         FZ+xqXrYiyjnBy7+9ixHKyBI97aBV/cjN/WmT0OK93+hjNt/wHa7JaM3uUri0zCmgYEA
         yiJAdlGduAYo0XdVJQeNgrSELXjWjZiRPm6NZdhRJ04sBEVAKY/4hckDXUzDZLd5scoM
         UAw9QHRjeVoe6HmcKYd2cYhZixrng9qGL7sjkb8fmTPQ/EpAE2QRV591FwpMy2hdVa30
         KjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773305916; x=1773910716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lvKkcyZd8G7e8ZicmAHZx0gDBEp6+O25joc2hW20ZtM=;
        b=fYjJZcsZ/lSQ4ZUQDC8uLod7F2lRj/4b3HpW4cRR6zhK3HUZwyMfBtCmvSqjUdkpTP
         qw1Wu64PYvNyCCMYkXcz4Y++IPXlvOSxSHmJc5ec29X79Fo1iPOiLZDHyhrIhJ8+mOm/
         9IsqzA6t847LmCiIth/KaxsW72KdeqyCnng4F3WBFsYbeIIF4DSOeGwvl2wZL6eS4zTx
         hbAlU0g/RR8xj3MDDZ83ZwgBpcXOeBMGEIqYqcsphUgIf7T2epkf753dGBf0XC7UvM+V
         7uS15OVcvcE4LJtDkHriOgYGpP08LJ2kBczqSkbpxF99kVIJJIRS4ComKDOb3ncrjWxe
         xjVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOk3AaAOrx5YTgot79iO+BnC6mKm8mQNqP6Gt9Yd84490ngjobS29S3IiOv3MC0wcoHMJCot++4Gpy3iokOzwsArw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHv2Npj0e2VQ6TmwS8tdERgfBJTnSc0XyrIJnNMajmfCgAj6YW
	H/0G6JsIMQ1uWWqGnuxNbyuDIT0OxOFaODdLqZFINE2EI2vzhQ/P6wMllNyU616gUGCC3/zhqC5
	csvzB8XiJeoqus+MnFFvv0uo9NDxjG/f7E1EcDv8=
X-Gm-Gg: ATEYQzwaOM8k6eS6YHEiD1pe+CbNecIX3qKCDIvtLLDAF4jn2+G7TefFqJfrWgg5Psm
	rNUN5F3j76YN0BTabkuTCCklquN3brvdv57cuNxb4MnmDU1/3HD2RVc3eyLQYycLSCE2lmrKHGo
	VnqzktGUYGb0WnoVVLekzwpNb9HAT0zS4wf9d0YyWLEoFEIL2Aec8A2mfAvTNo49/BCvjI223r1
	v+X5yR/S8RLj9vrvTMg7wEH6SgV5C9AdblRqapXYLdYNLiEVvKfMXw+0tvXAxrfS+EL/7k23DYd
	fQikKMlkGEqxEV4DBBM=
X-Received: by 2002:a05:690c:c4f9:b0:798:11ac:d0ac with SMTP id
 00721157ae682-79917f83a15mr53833907b3.53.1773305915712; Thu, 12 Mar 2026
 01:58:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311115250.78488-1-laoar.shao@gmail.com> <20260311115426.GN606826@noisy.programming.kicks-ass.net>
 <20260311125350.1d89341f@pumpkin> <CALOAHbDqYjJngQmmOaPRA=k4Bb8Or39YNp5R98f_op4dti2_TQ@mail.gmail.com>
 <20260312170602.703df4c77dba2b558b4c08e1@kernel.org>
In-Reply-To: <20260312170602.703df4c77dba2b558b4c08e1@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 12 Mar 2026 16:57:59 +0800
X-Gm-Features: AaiRm51761gKsakuRzNvkMzhgNaZuKRxVLFwMcM47R00Afa4Z-NnoMViinzn7gE
Message-ID: <CALOAHbDdkGAZySWMWvBv2_vZ+wVO-2ahtHwMtXf2f-X5UrwR8g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] disable optimistic spinning for ftrace_lock
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
	will@kernel.org, boqun@kernel.org, longman@redhat.com, rostedt@goodmis.org, 
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 4:06=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> Hi,
>
> On Wed, 11 Mar 2026 21:40:32 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > > Although there is a bigger issue of why on earth the code is reading =
the
> > > list of filter functions at all - never mind all the time.
> >
> > bpftrace reads the complete list of available functions into
> > userspace, then performs matching against the target function to
> > determine if it is traceable.
>
> What about changing bpftrace userspace tool to cache the list of availabl=
e
> functions? (or just add an option to pass available function list?)
> Then, you can just copy the function list somewhere and uses it.

Thanks for the suggestion.
Steven also mentioned this optimization, and I believe it could indeed
help address the performance issue.

>
> Of course we can do the same thing in the kernel, but I don't think
> there is any reason to do it in the kernel instead of user space.

Implementing this in the kernel provides a more generic solution.
Instead of patching each tool individually (bpftrace, perf, trace-cmd,
etc.).


--
Regards
Yafang
