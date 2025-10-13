Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B2D4C81
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399614; cv=none; b=lZCr8M8LNovAfIYT9G0meyfvWfQL+fl8cMfeTAxGe80Lpwm8Wb6d3SzVP1BIMvzlIO9Xsw7v2Ev6xNSqUvXq//GODbemcJ5/GSVLnMw/jH16VDowa1li+pP4m6MA4wnaI+elUXj5Kp3B4YbCu8IHENQn2+tJ/Q8y3Qw/TA4rK/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399614; c=relaxed/simple;
	bh=RIEJrE0uCmjzvjs+seL8p1hc+jZaxiG+Mobd5Medcfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilQZzifGJq+cuVhJhqk78iEbzkZEbQ4BPe/IzBCY2bYcDQJ5czWa3hKzNgosZAzEWEYJcexP2BvmIMWaxMgWlHJm22d1MLRXgUTVgZlYhlmOsCzjvtOc9cpIuTIaKq3qgI+XJulv3HhcfeRIqs932qaJA8ipnCB43S1ztVyZydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cV6k6MJ8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV6k6MJ8"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e42deffa8so44567145e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760399611; x=1761004411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIEJrE0uCmjzvjs+seL8p1hc+jZaxiG+Mobd5Medcfg=;
        b=cV6k6MJ8Lkf+6yirLU4QU8uGgecETWdcE18APqUPjQ0tZQ6CIB5a3JifNbS1uMf19s
         EGOD0RdmRDkyptiaPBWXE8VljBXcJizxoSX5a1y0TvOQ6+jgrzdpopELTuB3WBLMvhuV
         81qjF9zVs/jf9GH4rOXpeUQKYbnq1b+6+ELgkGYR3nUsvqgr+Vg1kP7nYZxanGiAStgd
         /OaRUVSCsKunR7eHyHUMHWcb0xI+BoI9afEVAKSEeV06XDqMVORTC2om5+WDr+ml/j1C
         s9KFsPlFOLrOYV1LyQygoHvdsv9CvAVoEZWH9a8VTDx0bt87Hsmhk2l79ZSZtXaLs9y8
         W1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760399611; x=1761004411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIEJrE0uCmjzvjs+seL8p1hc+jZaxiG+Mobd5Medcfg=;
        b=HiR85MxbpbZ4Pc6q4lNgqWhf3mreH/mgHuH/6dfZmva3hv8EDOBRaMv0NSBGZIQo+f
         DEumWX53Ye9HbUjEcdMu1FbhQz9WoufIadxZBtGW6UZQvDVxxd6uB35yKN05bU02RP+7
         vBzh5+EgOEjIhOsSbpq1TsUEhse1MDd0+IIkkj6aZG+Rrh8/woQlDP7rlWXX4Z5/T0PX
         cdxqVb/WhrCu6cF3IVAFdCgs8PXe+XHlK8h2Ng7LE+fmDpdSDPS5/UG6xdpuIUIoBMxF
         e7xpeSU6LYMg9FvGntL3dRXeqdQoFy4EggJDiIWEk5cy4MRaJGhR4iFd904vvK1ZT1jk
         1ZVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOo3/hRpkkP15SCwAwRQfUOSB+OpA7Noz4Ediw7LV/ADVOAU3+x440IICeOCaLOmont0S786OJPhnXr/yCvK8478k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxa1Yn+3uesSthFjujXC+WAevw0XnMxVYnECZqyctBWHA4Rc9R
	X5MekqjnbOOtGCSZNQWRFKkutxDblnmay/kdOdZIZncpUDOGUl/kRaUjvfz840UK6FQr3JVOXw0
	Iaa9Gjmm0FW03jbkBNQQUuDvonNxit8o=
X-Gm-Gg: ASbGncttd8nQPIPtcdRV7GkRSMzKiAN9zZFXvGWm/tmBu7OSAh+RDRSzuN7VZiwwlRT
	2XKc9VoGjFQx1udlOE+MfNa9g1fnWqDivC8ZCS8kmAfZ4vUbOzxLy+ACytUaRXCu8KdJb0BIsz1
	AnfHm5fOjpt3vlmXqEZh5PKMIRMTtrpmTtQgQGKz77aBULBTW0UlmjXBul6xdvWWpQVipoRNh6Y
	lBZVImj3pkcak3IpXkpn6jwV0LCULXUEXuspw6HXWLzf1s3xS6cAotCIm6AwTgVxBNKrg==
X-Google-Smtp-Source: AGHT+IG7qgaqiANTI64fKq5fdmN3jYIEH7WORYmY4wbj4MgVRoihxDtESxflM1JUMa9Wy0M8r0UWCelXBUFZ0Hk7+LY=
X-Received: by 2002:a05:600c:5028:b0:46e:428a:b4c7 with SMTP id
 5b1f17b1804b1-46fa9af2ff1mr156663835e9.23.1760399610941; Mon, 13 Oct 2025
 16:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013131537.1927035-1-dolinux.peng@gmail.com> <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
In-Reply-To: <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Oct 2025 16:53:19 -0700
X-Gm-Features: AS18NWDSXnedfjS8OY9WIaDlY9RiYWa2my_cqlC8rCnw82wSbTJtgr_XZ-TyNvI
Message-ID: <CAADnVQJN7TA-HNSOV3LLEtHTHTNeqWyBWb+-Gwnj0+MLeF73TQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize
 btf_find_by_name_kind lookup
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: pengdonglin <dolinux.peng@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 4:40=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> Just a few observations (if we decide to do the sorting of BTF by name
> in the kernel):

iirc we discussed it in the past and decided to do sorting in pahole
and let the kernel verify whether it's sorted or not.
Then no extra memory is needed.
Or was that idea discarded for some reason?
