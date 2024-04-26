Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE2042040
	for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115471; cv=none; b=GHW/Qe54/RSHlNkEHwx8IACghb2aDdGxYzuo8gw0+iQPDgBmKJLD9GNoTN+TM00MXp9O1rdBrqcm0QAFUpAIfizbGhAg0vpIPdwWY6j2orCC5u7ilOJH9f/rwZVgYYdx5EHwridBdD1bzmJltxdTRxyOgeRMxv7e2oUW3LhoK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115471; c=relaxed/simple;
	bh=DUhzpTck12VjCSqiHrdV6VqhVkIhc4yBLS1FXa70ffs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJp+DJfUfbC+ly26Zj4k0kWnCj/Q1Lfr1Biw+U5DAeGbcP1ndd1KQEtPYJQpue/PctWjSfejjF7ogqMb6jDMfNlgwruJB4DHnYfLCIxxUaiIVoGHwkWnvmcKZvUoGw6QZWBafX9FD3Rg71QRSluxBJAVDpIEuc9VN2iLsNL6Cig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3bmjmWq6; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3bmjmWq6"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso4972a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714115468; x=1714720268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUhzpTck12VjCSqiHrdV6VqhVkIhc4yBLS1FXa70ffs=;
        b=3bmjmWq6DISYF9inZpVLsB4bMiuDANchLyBWxi9n4RDfYxINBHdtK2i52SwjlKl2LQ
         6S+a0zOalSrSe3U1Yq08YlNU38OsjLAGkwBSgiIqmz53WP8qQED/h9PvK0U9nwwe1UVZ
         SIX3UsNA3TmsRMd2joW85wjdKx3aN0W6rRsClIM5hEUupCHMiMFf5JXRSgxUPOzxOwzp
         B2IXVMw/UDKG1YnmC+Ee3/NEtAmkbHm0l/VKntqGO1kRCedEjudX7fr5GJme/ukEVYKM
         JOh4CZlbF2s7cKKKn61c2lvo0Fmf6FwAuIZnJL52zKTMUZOH/3sfqPhgtaPf7w4o1RnX
         asHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714115468; x=1714720268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUhzpTck12VjCSqiHrdV6VqhVkIhc4yBLS1FXa70ffs=;
        b=ZONgMsYrdEtnJK4td5jB2pCDVlCGToSDimQ4N9r9X1MbAu7CEtlCYp+R9UHgEelgxd
         P4mU7RgquMJC3yaYAvZ0vxJGe/9izgZPoL5XEfnxP0QSiu8cKR8OWbe/Mwce4S+t0I26
         DOxNh8Zsyhr/syUoecwSwePfPARZbncK5w9ImO3stvn8q2DHQBxwbUW2/AonYEXUSoNR
         Gi63NozX7kiTVD/Y6D1/QtC9O1UIkQZFzddQXEHKwfyA6zNtelx/UT4aYJOQJrzBsDCi
         Tm8U5M7BetwaIT1aBcXuC7XQnnaBhVq3rnOgKaxqX9xDVbyy+kBnIjbV/ZiVxRKNztCv
         T2EA==
X-Forwarded-Encrypted: i=1; AJvYcCVniwWS4lc1IFSyWZm1WxB2vGRofxSLqjuo44Qf503o22M0IvdfzmKuVndseV2tzQKl4+LPU3UUQ4V3LsKgIpGmz525XC/aZa+JKwp5VgN56uy8
X-Gm-Message-State: AOJu0YyMSr4MEDo33iBEmcbmdqqyzFlTwDEPFacjFn/a1UgJ8Ld8A5lg
	5wgrN2ezRJCTPztYTrY3/OadCBP34Bh3vDhCAegGzQs67/wctQlPK3gEcQlm+5SpAt6G067Fwww
	ZUOYc+KFh2jHt+EkPMpQ0RehlruY6Yi8wwwIF
X-Google-Smtp-Source: AGHT+IGT6onk+BwIZ+XI6s2mJnRWIfjrCN+NeywEu5zdlZD6o0AXsRSokjeE2Rw/pj9o3mnVZIxQInsQNxEXv0d0IcI=
X-Received: by 2002:a05:6402:26cc:b0:572:57d8:4516 with SMTP id
 x12-20020a05640226cc00b0057257d84516mr43968edd.2.1714115468235; Fri, 26 Apr
 2024 00:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425031340.46946-1-kerneljasonxing@gmail.com> <20240425031340.46946-4-kerneljasonxing@gmail.com>
In-Reply-To: <20240425031340.46946-4-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:10:57 +0200
Message-ID: <CANn89iKZV=jg0ebTW-c7uLJxurLd7VWo=3GAqrjpWzDEovResQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 3/7] rstreason: prepare for active reset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, horms@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:14=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Like what we did to passive reset:
> only passing possible reset reason in each active reset path.
>
> No functional changes.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
