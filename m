Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2E11A7264;
	Thu, 20 Feb 2025 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740034143; cv=none; b=SXCn+LnXkQ+jRuh4yu8MTUijTK7ha7rUPV91Y066Nby/j13tKH0QfjDvMnsE29JJt9lf6T0C5slJEnC/PcJVEc2pdHRMIaehacn9Vfyz4Yx18NJDzDwvkzUgWezdjxPZZbVSbSqXnI9VuZ7ZB/m60pgRs3SNqXIlo++Hgrvqlrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740034143; c=relaxed/simple;
	bh=RXuv1mNf1i0mGEypE2/C9HcWQKV1YPHTperFuSc9gZo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WUzBJiubKqgyAxJNMHvMDLy/O61bsIeBjI1WbjU7nyf7+5bVo66w8YNRkA4qVZANPr6372O4uYM4ly+k8U+JbSQ5wrakd6Adr71Un/O/cG/Gc6sm7DSmqE2f7RPX+TfrV/rJeYMp1pJWYDXGi91GB7Svdvw7T15OXctcHeWNoxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyYobT8U; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyYobT8U"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e66b4607d2so2716246d6.3;
        Wed, 19 Feb 2025 22:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740034140; x=1740638940; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uKvxt+mJbyazxO0QGo+W1meZjuhFb9UqGB1qlrypOU=;
        b=IyYobT8U3MJxp6XU2twoNPsGoYe2nU+4FWUeCpdWIKSeBaY+3mA/OO89RqisAllGeT
         e5Hgu5Vxkw5Ph+2hbLzKsFkx+iwz+7mLyhKDIpC4qzNEl2/vJEbOkYeZVfG95n6XW2Ld
         a0UpeovrHJ7+BtwohNk/SxCUZ3hL1AJdEaIDUdkZVcccO4ctC8FzodPK6wC/6bthGi+O
         vchB8iG8/pqamUzQgkMGSpyYwRHdJOa7bYXmDuON8f6VzPJ8aIC7Mt1uj6jsUUfkHAAy
         /i2qr7ruMgny0SxbpS1HQBVzHlsBTu6k1fwAxYhzV82v15x2TIO7APMUahblGA+gPF41
         nEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740034140; x=1740638940;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uKvxt+mJbyazxO0QGo+W1meZjuhFb9UqGB1qlrypOU=;
        b=DCxemrRtNGRp7SeebwRi1IADCb68b1Hf0X66sl8MTTE7qvaeNniCRGbA0mAaAwq5z6
         C4ObF4zgLR9crq1FabI0Y9mIYJ9Z+ZTLv5IF16+lSZEb5KhnFE4EiCrO5hA3fEqL1puT
         vzQQ8kWoQYkEpyTxTVTJkyrur8SJlxKPiVsRaBRVUuUi/5AI+LEY/SzSbOUXBdfNo5jM
         0kyahaLtSon9H7MhBsa5Kcya+t1Y+9e59pA9gFZ4uJl9mQCVKZv8fQVMSjCfUYC/jyf1
         nt2UfLd5A8H3LPNvA0mCvasL2MTcYnyw0FcsFPbBpankthJ3XXajH+nyHZUk0onG+TL8
         qFTw==
X-Forwarded-Encrypted: i=1; AJvYcCWfLFYLmzCR5470V3ZUXng57TVFftgn9a3E/KIHxnpIJx64ZtYPd+bQ/OBSeo2cnI8n7EyFVDWd1IzckjjbMIukAHXd@vger.kernel.org, AJvYcCWv/6VnIpU0NHFnhts+/BXUa8nL/EXEOnF0Fd+O0rRq1gBM2gZmwlaTQcthwkz9+fjRR2viK7JfVPrXcMyE@vger.kernel.org, AJvYcCXszV1d3VvnyfDxzb4fyGQCIsKXBIjGpezJrVexMMBirLGP6o3+ycONSy+4ai87gOaX31Dg393HfHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy5c99t72N9xT/c7xnn0JujfIHHn3M/yM4cqsH3yVGjV9z8piL
	WV1YQIL65dtuVYL5MUEKlTqsb8vpeR+5X9L7bNv/yNbBtlPePz06
X-Gm-Gg: ASbGncsOr+yjAwhWcBzIuVPeKpVwurp6P/dzXZmMp1KW5qE393r3qwN6FKX37I5DaR9
	g4T6zVNBsFzpu1cBlFyvfX01i/bmdKtmwY0ge6t+NWU5PekDIM8xcZLGgvGHb7mqcEN58A1HTkJ
	dRzez6R+T9v/nW4uSIODIpWJK89YJ4nAEvOg12eb07vSkDeJtmkDi0N3F3zwu8n0ciC1OSP8DIy
	Q61Weu4TA8WJErxpxjqCGi+9Y6j5Bv6vQNP2ForOYr6dgnau0bQ9Elib3n0sB8GIVrPh+0kc7WS
	2dKMC0v7/v2VPy0EIQnelO48
X-Google-Smtp-Source: AGHT+IGCq/y9+Yj+s8qvVXqp6rh0Jfx2VhsqCqOW8/zizQH9jsIt1c23sdo+f6ZKThqz1A6xS1DRSg==
X-Received: by 2002:a05:6214:2122:b0:6e6:6417:aacd with SMTP id 6a1803df08f44-6e69752563amr98239486d6.22.1740034140186;
        Wed, 19 Feb 2025 22:49:00 -0800 (PST)
Received: from smtpclient.apple ([202.8.105.115])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e660f65c5csm77095846d6.117.2025.02.19.22.48.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2025 22:48:59 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH 0/2] sched: Refine scheduler naming for clarity and
 specificity
From: Jemmy Wong <jemmywong512@gmail.com>
In-Reply-To: <20250219172443.5a78401d@gandalf.local.home>
Date: Thu, 20 Feb 2025 14:48:41 +0800
Cc: Jemmy <jemmywong512@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EBFD5AF7-8B9D-480E-9A01-74898E4EBC60@gmail.com>
References: <20250219182020.393006-1-jemmywong512@gmail.com>
 <20250219172443.5a78401d@gandalf.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

Thanks for filling me in on the background of the code status
and the potential consequences of these changes.=20
I really appreciate the context!=20

As Phil Karlton once said:
There are only two hard things in Computer Science:=20
cache invalidation and naming things.=20

A good name makes code easier to read and understand.
I personally value code readability and maintainability.=20
However, based on your input and the community=E2=80=99s opinion,
I agree that these changes could introduce indirection=20
for git blame and make maintenance even harder.=20

So, I=E2=80=99ll discard the changes.

BR,
Jemmy =20

> On Feb 20, 2025, at 6:24=E2=80=AFAM, Steven Rostedt =
<rostedt@goodmis.org> wrote:
>=20
> On Thu, 20 Feb 2025 02:20:18 +0800
> Jemmy Wong <jemmywong512@gmail.com> wrote:
>=20
>> Hi, I'm relatively new to Linux and eager to contribute to the =
community
>> with some foundational work.
>=20
> Welcome to the community.
>=20
>>=20
>> I aim to help improve code readability and maintainability.
>> While reading the scheduler code, I found some naming inconsistencies
>> that made understanding the code more difficult.
>=20
> I do plan on updating the scheduler comments soon, so that every =
function
> has a purpose. But there's a lot of history to the scheduler code that =
you
> really can't just go and rename items. It causes a lot of churn which =
also
> causes noise in the git history, where git blame is used a lot to find =
why
> things were done. Adding renames causes one more level of indirection =
that
> makes it harder on the maintainers to do git forensics.
>=20
>>=20
>> Specifically:
>> 1. Some function names do not accurately reflect their purpose.
>> 2. Certain names are too general, making it unclear what they =
represent.
>> 3. Some concepts are ambiguous, leading to potential confusion.
>>=20
>> - Rename ttwu_do_wakeup to ttwu_set_running:
>>    - This function only sets task state to TASK_RUNNING,
>>        not performing the actual wakeup.
>>=20
>> - Rename update_cfs_group to update_cfs_group_shares:
>>    - The name was too generic; specifying "shares" clarifies its =
purpose.
>>=20
>> - Rename place_entity to update_entity_sched:
>>    - The function does not handle entity placement but updates
>>        sched info: vruntime, slice, and deadline.
>>=20
>> - Rename update_load_<set, add, sub> to load_weight_<set, add, sub>:
>>    - "load" can refer to either PELT load or load weight, causing =
ambiguity;
>>        "load_weight" specifies it's dealing with weight.
>>=20
>> - Rename struct sched_avg to struct sched_pelt:
>>    - This structure includes not just average statistics
>>        but also sums like <load, runnable, util>_sum, =
last_updae_time,
>>        all of which are PELT (Per-Entity Load Tracking) metrics.
>>=20
>> - Rename init_entity_runnable_average to init_entity_pelt
>>=20
>> This patch aims to improve code readability and reduce confusion by
>> ensuring names are more descriptive of their actual functionality or =
purpose.
>=20
> I personally am not against these updates. But as I mentioned, there's =
a
> lot of history here and it's really Peter Zijlstra's call (and he's =
been
> against changes like this in the past).
>=20
> So please do not be discourage if this doesn't get much traction.
>=20
> -- Steve


