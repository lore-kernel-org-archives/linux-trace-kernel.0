Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA921B85D3
	for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Nov 2024 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807563; cv=none; b=t/3gU16Nmh9RdXR54OIB6YWPqt5qnkPs++2ognjUjnlg8ozhD8SOZZWwqsL4qWoQwx3KQ6ho0FPsWJfS3uYkaMZsBtFr/OEyZGdXRPbtgFxZeWj/SqTgl8qqvHyy9CemXNrQoyXjrIYmAgonFrKuUyO6sRVTJqvVgcYdkUXMCU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807563; c=relaxed/simple;
	bh=MXd4l6+iQmQnfD3BLnMGFSdnuuNa/etFN+OYpi5oBN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwz5Q74rGO2xN21appkuu2PmPI+9RsqYwMfDLj/VugJqFqOdloQIQoAyR8GkdF81L64HMDE1ce/hLJIQf0IHlcPpnPZr6sK4UDZO7cCMjPRCjij2NWOCsYSJh2WMo0cz4y3+pjEKa1+WGNXO2tRrP2I7LfbSgK9slYOk3AC7toE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PzvNaw2w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzvNaw2w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732807560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXd4l6+iQmQnfD3BLnMGFSdnuuNa/etFN+OYpi5oBN0=;
	b=PzvNaw2wxerQFT4zymu6f75BtWf1ttnZjnnKzVem3OkBRRHZbF3uZ8zMXZbNuLC45brrZ3
	NKRB9I0RiFGnJixkstcTimPJ8wuCkjWR3YDHvAzbgjVKONwhK0bD7jSiFWCJilOlB2d0Kp
	PhFxeE17O1m8GL3PxxjwRKHYJX/8iYQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-TFTSqVr0P-GbBi8JbpsTGA-1; Thu, 28 Nov 2024 10:25:58 -0500
X-MC-Unique: TFTSqVr0P-GbBi8JbpsTGA-1
X-Mimecast-MFC-AGG-ID: TFTSqVr0P-GbBi8JbpsTGA
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-53de1800c06so746350e87.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:25:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732807556; x=1733412356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXd4l6+iQmQnfD3BLnMGFSdnuuNa/etFN+OYpi5oBN0=;
        b=CiE/kW/+2TKO4AHTfKXG/UiHEEXcJg29dKw0N4Q5wyKn/HTTt2KjplmQnybxUJZKHO
         yQ03OF6cEhy17OM3f2Sgxrf1dBJwO/3xJW5ktJzBBrFeE2U5tSt/Qzsr14WXyFtPYwqT
         zhutUVlV+g3o3CwguVG3kL3un/mzKlAcz/vSFoNOovL6tbM4hHF4On/GqZgxYA7TW0tN
         LNa1t0Y1/8kLv61U+JH8VsBZGtAmlFZdgGIvgeWH83nXfrC+6GUusuKy0FBIcCxnudCK
         d6Hu7NzWrtAVGZImLA8tMzklqfqEsaoYpzPIu5uP1IhpvsiAbLgalUvCTUL0nGIfDX7l
         bLUg==
X-Forwarded-Encrypted: i=1; AJvYcCWyxxHJu3IcTNWvjpk4F+t2MyFgBihDs4el14qcuXYbzppP2M/RgrePljk7XkWEnOT68vjvYeDUiw9qGb3L/p1T2Js=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMvDz8l83+5gY7xeHA8htLLZXKYGCEQsV57bpUilGGZ1rjL7xQ
	zSbEvus6ZAEyKAIolkH2jz7f2kl8hBCaKELlVYCgptGZ5ZY6TdsFKsOMtheVXrKQe26UdACy2hZ
	ZvPbK//wIArgEgK1Vx60jtDNnKHec7noZUvsBtDjIGiJu5OhmDqF2ny2ifFiqBULwBAu0Xp/x+r
	qXdBejFQbColl6Wk3fGxeHF3DpadsF6eveIwCF8p9PdJYUPbb9ldqHOi/2/A==
X-Gm-Gg: ASbGncsThjmfY1S52cDP1Yi/aTIEcFtp/1v67LnrnHtW/nrdtvRGs3TSxJ47gKwBZhx
	WtCuWUYpomNwFz0Nl4nJKvHuPPnu1Sl4=
X-Received: by 2002:a05:6512:32c9:b0:53d:eef7:a017 with SMTP id 2adb3069b0e04-53df00cf65emr5725107e87.15.1732807556120;
        Thu, 28 Nov 2024 07:25:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUDRgJvQYM+JdFcJ++bS15Z0GZU2YBr+5bjatsFWQinG+yirtbrqloo2N19HWJZBdciblzJX3Lg8Gg/26Guhk=
X-Received: by 2002:a05:6512:32c9:b0:53d:eef7:a017 with SMTP id
 2adb3069b0e04-53df00cf65emr5725087e87.15.1732807555727; Thu, 28 Nov 2024
 07:25:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
 <3a8f6faa-62c6-4d32-b544-3fb7c00730d7@yoseli.org> <20241115102554.29232d34@gandalf.local.home>
 <cbb67ee2-8b37-4a4d-b542-f89ddae90e94@yoseli.org> <20241115145502.631c9a2c@gandalf.local.home>
 <2c43288a-517d-4220-ad31-f84dda8c1805@yoseli.org>
In-Reply-To: <2c43288a-517d-4220-ad31-f84dda8c1805@yoseli.org>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 28 Nov 2024 16:25:45 +0100
Message-ID: <CAP4=nvTjdZRfWtpvM+gThPv6SghW96i9YykA88vAFH5x39GZqw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] Add basic tracing support for m68k
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x2bIU8yoVR-s6o-Bo5T9Yhh0YBTX9yNZ2YpQ99rcbIc_1732807557
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 18. 11. 2024 v 11:13 odes=C3=ADlatel Jean-Michel Hautbois
<jeanmichel.hautbois@yoseli.org> napsal:
>
> I had to modify the source code a bit, as it does not compile with my
> uclibc toolchain:
> ...

glibc added a gettid() wrapper with version 2.30; earlier glibc and
uclibc do not have it. That can be fixed by conditionally including
the inline function if on glibc lower than 2.30 or another libc; for
reference on how to detect that, see how kernel self tests do it [1].

As of the FOPTS changes: are those necessary for rtla to build, or
were you just using them for easier debugging? AFAIK rtla shouldn't
depend on unwind tables or stack protection for functionality.

>
> But it is not enough, as executing rtla fails with a segfault.
> I can dump a core, but I could not manage to build gdb for my board so I
> can't debug it (I don't know how to debug a coredump without gdb !).
>
> JM
>

I have seen a similar libtraceevent-related rtla segfault recently on
ARM64, which was fixed by updating libtraceevent to a version that
includes the fix. Such issues are caused by the files for kernel
tracepoint tracefs having different contents on different
architectures, exposing bugs. I see Steven has already fixed one of
the issues on m68k [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/testing/selftests/nolibc/nolibc-test.c#n1008
[2] https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/commit/?=
id=3D45a9b0647c904b7bf1240da5a11fe3a1ffd1006d

Tomas

