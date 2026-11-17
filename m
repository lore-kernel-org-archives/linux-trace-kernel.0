Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794926581;
	b=HDA9l3Ixr4a0HTeRQEN0yOcXCvQR7+TOBlOT3GxeywEPFDclDT5g+4B5kmxWZPfl8aqg
	 NOEJWAUyyZqSsbkssWrVsY0aia8SifTeGtRGw4jouTmbRX8TS/aqu4N2CuQCo8deze4S1
	 AntGtT9GYCbmGt6iVYFyuKTWPpgH/GqdCuw8Ip7qJ/1aQj3u5qDVghGI1Fguc1QG7awxu
	 +lkR4+VCVX4i5zatSiGRvSED90K8aA46u29jFT4qnMn4oIrIwy0hSUGAhkaZxmady3tFm
	 rDDX2tbVdF8irY0eLILivtWdbhyFrnYdo5ei5IRVkSckFYnUGa4kv++H8WKXpANRPhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mFFppih0TKeAmBlozegLc3dJO4TeAO8W9JK0t8QJe+E=;
	b=easgg+yMbPdCUXAotqj2clX8DaSrLtYzP4ltfE+zU4SNwCa2JHWSg6rc21sDIDAqhkaV
	 rQOpFYuYNTXb8ajdW+KYYvZ5G5kQQpaRqCs/gvXmxKZyd6S2AhDYn5WjqzKKf505IpY1f
	 O6vT7pQk+YHOvnTdPIIyzEGOL+uWSpQJJKWjXzD2kev89/UzxWjh+TgsnO5OR25NDsNJc
	 DzKdOzZx+NJw+stGIBeAJtwGu2gP6zlSS09OImQnRoMaWDjRXw+eJ+Yd7Q7Xy4zb1+ycC
	 B+TLZ91rI29AOpMzNz+MRdGXiIV/rA80VHGldE0sXkl3D2eB5yPho7li0Ixo5J0tktg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O6Ln6cNQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.172
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7C9606A331
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 14:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F7C9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O6Ln6cNQ
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4d7034a99a9so3288789b6e.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 06:43:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794926580; cv=none;
        d=google.com; s=arc-20260327;
        b=PIrdksoV3+8jCrulBHERFcdHBfDj4xG+jp3Z94u5sl1QMS61UHhGAZUkAakhke42NE
         ZYdxjvFNvhsGNz6+HIvlrzxI4j477+U66i6lsU9sUCcWqbdrGn2hIxKlapRmut4l9zzU
         1nDDsLiyvS6VMqW0zlnyk7RG/5FNimgvZ//jhNKxdqOwBbz6/xXsFExSebNQhLfpdpTi
         KIB/aXt+ZNg+0BqdIOy9Oic6+ocBPTvwWOIQe6YYknHP89S96qWCx9HPjfEukjiSmUIO
         nEdFKyJzsjSBcv69gTSPe5DMnIK8SbDDqgVNBYj/Um5DVv2clD+9fXpoZDzV5q6HVEy/
         zW3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mFFppih0TKeAmBlozegLc3dJO4TeAO8W9JK0t8QJe+E=;
        fh=D4PAr5kctdbtYF5KHqy2wE82ee/n2LaEAAU4lQ7DGCs=;
        b=FxNyqPZxgMkaQ8ome9c8yXC1vHObgp/najpfh6m3ri1/NtzwFomNjStUpFEDPJ+xex
         B2O4Un6jcci5iigaOOrYTOVOgbBQKueEodfS6IL07j041gTiAmAhQ0bLQ6PoeRLOVtzL
         9WEM17j4plpCAxjBOhy5fiwgDSpDRb3OruBwnWaSGn/bX94UNaYpiF8rlnUCIZp0OrVl
         /aBeY/Sxls4Icurkb4L7PodzhhnKkylfBv0S8rlhWpRKKNb57V9XPQClsY0rhusRHs2J
         r13nspH8LGfx3agHA/p1IJihGh2R/PeDi7+mcM+TapH+7SnrbUOPr1ftPBqHLLzYIwke
         ARKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794926580; x=1795531380; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mFFppih0TKeAmBlozegLc3dJO4TeAO8W9JK0t8QJe+E=;
        b=O6Ln6cNQMuiuepdGSPpDhn6qnko69d0XM1vdJXOExS9fHlkZ9AIBmUgyTjYg0Cd95r
         GwHuC4GN5w5GcDks146mqFgUKxfokVPZPBwuhF4WHO52CnLqLHkqaVq22uWr11Yxvcik
         HmnlodFKY7CZ7ci4Srux7Zlky8gptnil5PyAUrTfd9hrGkqXhpegoTsJMAvN2fBS+klV
         rgdpp6Vz1m+S34n36wdZgwUBFe2ljQLjal3qVnUIfXg0IeZ1NQ0FjbJKFI8pWJ4L0L5s
         XeIWkAFA6/h3F971sN4Ix0FjTTxpVxyaEe2an/1ZftZCJF+XSAlEQVL/nt3pdIfEkpVb
         eEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794926580; x=1795531380;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mFFppih0TKeAmBlozegLc3dJO4TeAO8W9JK0t8QJe+E=;
        b=WuuiiWgjkHSFvd7ol6v8T6J8MB6mhwvM4M+Yi8kJSqIBlwtV/6mtoNNEXdpIITDK3K
         RYflnzaJ+tZ+mR6SJJCnDXEltOJ0yBIvEBPFxxjIVQ/DvAtkFQJ+iYTXHQj6ciok378j
         Ph1WGmHuoyucJMSnrogEj++2WDBK5DgLNOG1v2HQd1NSH6v/CBwrdleib2+ELAafJwL0
         9XIjkuNC/RbKDvCtzbcWGf1psmlRG+++TzOgnuIoMhdhmdvMBFtrS1WE8XKIIvfXrgGu
         R3pZHZ/yg3UolxZH/xDDNAQs1iD60LzQMgbDJJOqBOwRknKLVk/YWP05U3Qyeh3evucx
         pinQ==
X-Forwarded-Encrypted: i=1; AL+hErGW/GEBQI3qbZur4rToYxBSojmFVSrIdXsRPHrokAQw1AMlXCUrzdsy+QGQ+TyaFLGtvAN0o20tV0UHHMZ7P6Bi2vY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/FLcmG3sN48gsS/mkeAkOAa39sUfr9FpxVdhw4a1aYlsYV7gMA
	lVJeCQTEGqundnCcSQ314i4aJnOGgv2oDKQ32fq/IOdkK5X/TgnNmiHftVy6Di3gkgChTMgjVtC
	q2tiobx71tuqqbAJpXZBmdM2DU5GyBro=
X-Gm-Gg: AYBFou2XghyLXa0cTomZQuL4usaKyWOfyEp8c1WPi6f0n4HUM7he0US4GlVR7RDni8I
	Lergh/JuZRfH11TgIIEayaoHZ9Ugvl8cFW/81mAWb3poJEAMG7qpnTgLodS7k0Ag6nGdew7mNGJ
	m7IZQEbx7Iv+okWyWFMsHUmu5cIbxwrOm017IM5T809N1UZ2rUN3ItPOPXQr2IApXnL+upTmlFo
	1XbIyfctvoHLY9EcloE2WwrpxEMdAPU/F6C1+AdMlqKoAK4tdmbGVkMyDORSjAYEJf9nfhsAthw
	jJp7guCx/3HnQ6GKB9IZs723TPfVwNLmA25nJDBz9RD5W9FDKOWYDbFJRagbDWvjdxqbjirzdT3
	ukPhqxflqX1YWh8nqY5SF/jSchxKbo5PAEv/RiUzk60q9PGJ8iKPmSr+cOjumQ22HpiXdFB3bSn
	dx2CE6LGAtkX3Q1NmFvcMBGNLgBpV7vRYXFy4rlPQ=
X-Received: by 2002:a05:6808:30a2:b0:568:1099:ce28 with SMTP id
 5614622812f47-56e65002973mr12925992b6e.61.1794926579964; Tue, 17 Nov 2026
 06:42:59 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110132013.732-1-obabitemitope765@gmail.com>
 <179487776546.3663701.11916478949345242482.b4-ty@b4> <19df2f93-adbf-47d3-84ae-6cca78b34df0@intel.com>
In-Reply-To: <19df2f93-adbf-47d3-84ae-6cca78b34df0@intel.com>
From: Temitope Obabi <obabitemitope765@gmail.com>
Date: Tue, 17 Nov 2026 16:42:48 +0200
X-Gm-Features: AclHuK9knjaTAf6HGBpcCieJdjJkhcXQYJekWka_wZYVkElFkWnL3lmGgX35pQ8
Message-ID: <CALUk5xb+WR2ArV0vDst_H=zjKCAe90saS05MKS8YXdUFMUOsxQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Intel: Remove unused sst_ipc_inbox_rdata tracepoint
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	=?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for the confusion. I sent this as a new thread by mistake
instead of as the next version of the earlier patch. Please ignore
this one; I will continue in the original thread [1] and send v3
there, removing the whole header as suggested.

Mark, since the single-tracepoint patch is already applied, I will
make sure the v3 header removal applies cleanly on top of it, unless
you prefer to drop that patch.

Thanks,
Temitope

[1] https://lore.kernel.org/all/20261111223102.1310-1-obabitemitope765@gmai=
l.com/

On Tue, Nov 17, 2026 at 4:02=E2=80=AFPM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> On 11/17/2026 2:09 AM, Mark Brown wrote:
> > On Tue, 10 Nov 2026 15:20:07 +0200, Temitope obabi wrote:
> >> ASoC: Intel: Remove unused sst_ipc_inbox_rdata tracepoint
> >
> > Applied to
> >
> >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git fo=
r-7.5
>
>
> There is a separate thread [1] started by the author that will conflict
> with this very change. Ideally only the "remove whole header" version
> should be applied.
>
> [1]:
> https://lore.kernel.org/all/20261111223102.1310-1-obabitemitope765@gmail.=
com/
