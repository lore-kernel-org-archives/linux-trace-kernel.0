Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778690;
	b=pfxz4GFLMS7iOC51pwKkf4F63100Av+gMUIGHj2P8pZ+CZupiSW5PCasWpdVCQVVhihK
	 UTiMeIlpz2zY2jTEmZ5WoMWcYO5XH9lMW2Syjl02rwi86hHR3CcgK+cROS2YvhEllbudH
	 BIUq7owLy/jDCd1qsHuQKbQeQ9jVT0TCgGe+O5TbTPxNKyblgnsKLJFIMHD7MFn6uOiiI
	 9B3f020FiJR72w/X7pI0tIKiDSUNux+uT+f9ZPNEtJcbd9UgP/KFr5IHB5eJRH5lFfCTP
	 WPhjaEmKS92vSEKjmY7d/dOg0YL1XD1vGbWSETNQzqdqZHxu41K/fYCTbmPbLvApv3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778690;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ChdNpfFMmfSeiMhhgq9rOjsI8hm4xzlZkNy7PE+mUqw=;
	b=awVPBoDc8ximwQOn5GJK7i5D9JWFhhseOdKMyte6FM8JV19pWL494rcPjJUFuduFKrE4
	 2qcB1L2OTW4m1fLNG4Sht54caFnxRjJyJzebfq3HI4rsCGJESY5G6eFJJRB5vDA62fSHl
	 ZrLEpKCUEOmbo2+gZwMOGfdzh3mEP5EJvp801nzGnJswIDIWKqrPImSK2yQR3cbvoGqLu
	 RyUxPxsLzicbuMJ0GOPQYTTUWGuPBe3xBw9PHLol2r6fjC4ePx1xoZ+bNMGF8TRu237DS
	 z5PCjk9TKi3893tC8OjgNiPhHoT/qTf/qGo1JXfje72d1TLhlG6sD5nZva17HHcaYBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOq9mBSo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74EA606A31D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOq9mBSo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5CC1F031E4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 18:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778689;
	bh=ChdNpfFMmfSeiMhhgq9rOjsI8hm4xzlZkNy7PE+mUqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oOq9mBSogEELRUXKdb8J6x2Fr8brsYoQrFkTwYC+3qVOEkdIyhvQAHtMITZGVv7ED
	 d73ZmMMU7knCNrQUmetRG/hD3VAqZXnslhaEOh9RxbNigf0z85T9nl+uDy0UzJ1Pa8
	 wAWPKvDVXxqu3cmswLZjhyGIpaYhVah3ouCz1Sp3WJ8hm9NXQ8gb1dGiDDOVC5k0sz
	 EfEwsNmgjT+MpKCzfLeM1E7toi3SS0qQeRxeSkN7SyoEOLXKphSLJLW6rqKslIxza0
	 kXaUTZdMX/srHRKT683vhGm2HEaqf9FnbFIBSM/ErxHzm2CMHahNxl/TmSk8rhgWoV
	 ULhoF2gbX+v8Q==
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93f20b304c0so103625285a.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 11:04:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzcdmdNdI0eMZckRNhuUloZaHGv92NWWJxn1djAOGoUqwZZqWP69q3sP2RuKwH9efpY3tmZfzroX2ul8vkq3dZG0NM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuDAkzt+vJNrt8dfwVDBaZDJtqb1KF9jDY8QNfWWW8S5P6es/s
	UM8MRr/KqSJD8PmZLIbbakBoeOM7C5V0qePwWFNlXNxZOr7XSUddPco1M9BJGZkWjnmVWFP8ubZ
	C9X3F181VzZGVDXLELDzAy5JrgG/l/08=
X-Received: by 2002:a05:620a:1793:b0:936:df48:d507 with SMTP id
 af79cd13be357-93f6f91b90bmr544428885a.18.1792778688699; Fri, 23 Oct 2026
 11:04:48 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023011049.1164625-1-song@kernel.org> <20261023011049.1164625-8-song@kernel.org>
 <20261023093256.20d3e300@gandalf.local.home>
In-Reply-To: <20261023093256.20d3e300@gandalf.local.home>
From: Song Liu <song@kernel.org>
Date: Fri, 23 Oct 2026 11:04:33 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7wgXmQ7QKf06z1kiR+-5VbbrZx8ByLPCUXZtw2-SAHsQ@mail.gmail.com>
X-Gm-Features: AclHuK_J5P47a14LkpdtNyyppX1AvylBaLgmpgm_44519CpkozMkFuPGPPAAYzg
Message-ID: <CAPhsuW7wgXmQ7QKf06z1kiR+-5VbbrZx8ByLPCUXZtw2-SAHsQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] tracepoint: Mark __do_trace_##name() notrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 6:33=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 22 Oct 2026 18:10:40 -0700
> Song Liu <song@kernel.org> wrote:
>
> > __do_trace_##name() takes the tracepoint SRCU read lock and calls the
> > probes. It is called from trace_##name(), trace_call__##name(), and the
> > notrace rust_do_trace_##name(). It is a plain inline function, so if
> > the compiler emits it out of line, that copy is untraced only because
> > inline implies notrace.
> >
> > Mark it notrace explicitly. No functional change.
> >
> > Assisted-by: Claude:claude-opus-5
> > Signed-off-by: Song Liu <song@kernel.org>
>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
>
> -- Steve

Thanks Steven!

How should we proceed from here? Will you take this via the trace tree?

Song
