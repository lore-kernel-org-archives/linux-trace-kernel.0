Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE93530CD82
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774509216; cv=pass; b=GBXIvxBML8UHSY4zyH9VdY1K/1RUpHPHJcPcTyXijGECuOuPo/E41E0jvYdNErUpCZ/FeVcxTRsV7YBs9XbUzu6e9v8OtQbBdlgXJLMORKOQdwOCwLwi6DpVQp7LxO2CgWC61GWMTdM8afZ2AyFNDs7GYGIiw/dunnKOvRs/OME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774509216; c=relaxed/simple;
	bh=/CB4TmTiZlpMhk7HNXh/AlPzX8UvAaqW5s/OKUIlyDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWQrD6+UaMhfwswSngccTCr2VWTtTyHRzDMNHpycL0BDlo56hMKcyJLbDpHOgPPa/d6bI/fyz3FngB+Fuul8pCCX6sIjmBHNdK+Gdrpt6T6UCijBcMBhgXfKQdzUBmW0H30K+ANFv+gnJ2creWG4CUoUbcyzPR3Cx/QGjqc/PQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rB1SMZCG; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rB1SMZCG"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66a851e62c6so572805a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 00:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774509213; cv=none;
        d=google.com; s=arc-20240605;
        b=YVBf0feQwWG2OrjGjW2/ab8G115CiNXKSTaAmlmJV9/troGOJF7vD8rTvhAFUg2UDU
         ut8mHq8sY2EHDvWUxsS7JCDRIlm5zQNk29sDR46pnENj/W7hd6M7WsuOj9g+n9q4EO6L
         pe4DjlJf6Ik4m4Lq2kR6ytDLLwfIyOJg348Yx8eCPRJmCEttgz6jMH1FtwXua+oIB4la
         Foo+68u8y2B6AVapvz0Ff9OjPA5bm+mpgEXx0rEn7h9Q79kGdfKydUy5qyddzqYMGMcG
         22KPpGo36ANOUf4wDeURjhzMWhvbLXbPCwnsYlIcjsnijg8b6TChuLpuKW3SwxKUYnsn
         kR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/CB4TmTiZlpMhk7HNXh/AlPzX8UvAaqW5s/OKUIlyDQ=;
        fh=cg+eUlq+CVC9rbOqCQ0oyh7dU5jXVRSbuDvlVQGLFTk=;
        b=IppHsON2pX8cHr6zqy7reRmoj42xkpYWpgZTu22OHfqVvlanCOZJB243ETD27vVVKo
         Id7qTQikcGb7/eE1h09ETqbbsOC9haqCqSd1W0BmbDdt/C6cpauzMupbOG3Z1k04gdLy
         3xjbl+JtTwWYVx6b4bMBykcdBJJeLeMiOl9ENgZV3cu4Lk3MpCWQau2vIM8T8ViUKGA+
         1nKQXhmLV1r5gZgI5h+77MgXJ2pMriB2CG8B4yr7QcNjjKbDXjweJXqF8ZSdhWNfFwgA
         HIYs68IE87cq6Yb5aGB/oMr/sIjQir49tZ5/jkdX68fqEcTBzLwrLUxk/SZoYApGVJIS
         ShbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774509213; x=1775114013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/CB4TmTiZlpMhk7HNXh/AlPzX8UvAaqW5s/OKUIlyDQ=;
        b=rB1SMZCGITq1tVKsatq/yryA3vGnuekSTZBTQuM4ftYlJk58yRKxZxMpEt4wtz63ui
         jEdk+hSwekxZB+5Z2Gjv2rFDNwxo2OekHJP17yrSm1fhXIbT1WaXiY434P1bbutwlGuE
         LNyX4GE07fsIrZjeA6mU8Cq48ckYAQ4UEKhRNIG87xSS4yXpXZzexrBScl+unBs1Q06w
         vI+Qfu7TQt2WuttLPbRVfYpwguxouRVs9BY6LgkJUw1kHcNuuI5lKXMMZ6kMt1VIE69N
         IsaSbIQNCT1HNI0kAaXWMDWXuk8DRPvYd46UFLzjINMdqru480X2Ini0WlrI49ENByLQ
         i4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774509213; x=1775114013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CB4TmTiZlpMhk7HNXh/AlPzX8UvAaqW5s/OKUIlyDQ=;
        b=jPaHnmTerbtchXE34bxJooajoAzul12WOSTMr9K+zU8pzRG11nECzbECi0KO/aMtZp
         pe1ybu2Fcnc8VVX5AKOlOGE2woyguZ4kdcD7vQarshEdBK3W/ptS+xtiiJT4sVqGHKBY
         JswWr6lQhH9IK/QzZFOB+E40p5tZJBfCWqj0eqNNtU6Vm5fbvkqYlAcvITzC+N5zU2ce
         dLv5kqTUBI8jvlfwVbTCD8O143Q0qhaU/VOrj9MwAsmARZDHRQlSlRM6x20y0NpRSEXS
         EVomF4QIiSI4eyLcdqusQOcneQtSfxEaX+V21IUp6puXnn0LFbiSkcFtViqfXTWsDHtf
         c5iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjBHCQtOt+FoN1u8P2H9WD45ZUnuMTSCsidCoTzUmgIzZmegsOGC5zWSB7b6Khn7XD8xx77rjB2p619XVIyjcR9yc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyla7XxVIofw5BybjbW5mQjnYO5ttm29m2TYSZFbh9ioK5GkMK0
	3i3T7ahoYM6lRNkFM0etPS1KH4BcMANYUSWI13LGrezERSna2UdIgehSB/ZK5OXYIvtZDl0Kcap
	0GZuYdp6jEUrRM+dO9wPDmGGPPeEchM8=
X-Gm-Gg: ATEYQzyczVWABfZ451W4LiAcuA+yvJLJF+MGNyG3lRKyxqFIKBxzV6jfx9whSnjs3n6
	RjxUZpApnd58/NMBsR7BWQOAway2qp4l59/zhSSbJPzG5z2HCsnMiz7vQ2dKQ/M64iGBLt3H5ad
	tHNSBrAXPbx4iHhMFPNHFBsLBRIjIYff3SdpUM50FOH4kt0bUlmaXPIhidIGQIQfO4G8d+evRBQ
	cUUBHC+RflDLE20ClwvyHQ7sIA3LTLkdfq8fnrkde/8rOs9QRuV6bqXvYKemysfV4pa/WEoXNAi
	FQaZV1NU9Vqh2ejH
X-Received: by 2002:a17:907:198c:b0:b94:1d92:7eb with SMTP id
 a640c23a62f3a-b9a3f1919eemr458328466b.18.1774509212875; Thu, 26 Mar 2026
 00:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1774403912-210670-1-git-send-email-shawn.lin@rock-chips.com> <1774403912-210670-2-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1774403912-210670-2-git-send-email-shawn.lin@rock-chips.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 26 Mar 2026 12:43:15 +0530
X-Gm-Features: AQROBzDzOlAx1sUd2S5bjE5iJHmFf32DolWrjZ8MKJ0g213qpmInERjK8VvyQ5w
Message-ID: <CANAwSgQMy2q18Pkg7caunY2L0MwuFjugX6T4A4egSk38x3+FCQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] PCI: trace: Add PCI controller LTSSM transition tracepoint
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

Hi Shawn,

On Wed, 25 Mar 2026 at 07:28, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> Some platforms may provide LTSSM trace functionality, recording historical
> LTSSM state transition information. This is very useful for debugging, such
> as when certain devices cannot be recognized or link broken during test.
> Implement the pci controller tracepoint for recording LTSSM and rate.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
Tested-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand
