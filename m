Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502613B3BE3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 22:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782340624; cv=none; b=ezFJIyaRpPZK2o3aJt6BWlCgeNS/0HYMLAaHLK19jJrVPBh4CoGEl35x2xcKvo7lS293ata9PfAeTZfTGPINv1OwX4E9DbBue5b9T4TaOgsVb/G7lkoXoeA3scrFVxOhLrHYQGK339d2gvFdyReNPW0AEmWQg0Z0Al4x3Mr8LQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782340624; c=relaxed/simple;
	bh=gdyVLd+a+FGDT/pSJKMKAm2R1Yty1078O+Tbm6HxCWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQ6MHVsXFBOJetF2MxnBymKahjCDhpI+n0Qf0DZq7Iggv+xdeYAQPAF2yDwRxrW38q198GJ6xaQQHzrdogcP5gtaspz8QDJvUmj23CiOJj8IPq/gMWcV06VPqwmn82kbbQsbqPxY+RHkzW0KahUn1ggoEMDZe5fUqROQ5Voxj20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9LrCAKf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9LrCAKf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9001F00AC4
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 22:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782340623;
	bh=40fozanXZAxdlzneNHkPG5prWoWrnHjv4DK5nYpBKP8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=c9LrCAKfczx72V/MNASmoT5/6LNaegoXFkGVJRI3xEjWqoZyGaf/QtqTQO1Dg9OK8
	 SZDkLNrsnnBP6/xrg2Y5VPu9H3cUDZFaX1ZzxS/IVmRispdlhxltPUNV5BPaeUsgmO
	 PrifS9IeGeM6LYdqLkoLH/HQcgGGdNMClTqEvLTpPOA7KFOqQH8XACo4/BZtYeiH78
	 iG12/tq7f50dqAWTDJ6GuJp6z8f6wiho6xoBkYwH3jOZ1ZodOo0vD4SzSgiOO5umwO
	 XmZx5wAdupDfEYov1Q4QgnHv4T4f91XN0hREiY4THNdSFrU3rHW9njyCivR0NtQ7n3
	 E4iu/VIQZJgzg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39677245e15so13403991fa.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 15:37:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RptIMeiQfhv/2OeLYXWUpLzzy9F+iD+NiBAjh87GPtVtk7FoOJHN4ZTAz+Rjre1ni4GHkEH+RfxeOuE7Xv87DFgp+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCJaesETuzt/q6WIjPeTOV+1O80tdmdXa88AHjoZxQF9NL3EQy
	/OI0yDb948Adg8te3pkw6ywvAopx1FTsEXCzTVARHkHGKzTbx6ajQCR8PFKSFYvNvigqckUyNzh
	WaaRi/jauvXdIrgONGmdc/G/gFjg2+AY=
X-Received: by 2002:a05:6512:1352:b0:5aa:8824:1571 with SMTP id
 2adb3069b0e04-5aea1f5749dmr1552e87.49.1782340621797; Wed, 24 Jun 2026
 15:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-i2c-fault-reporting-v1-0-6db1a8aabf18@mobileye.com> <20260623-i2c-fault-reporting-v1-2-6db1a8aabf18@mobileye.com>
In-Reply-To: <20260623-i2c-fault-reporting-v1-2-6db1a8aabf18@mobileye.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 25 Jun 2026 00:36:49 +0200
X-Gmail-Original-Message-ID: <CAD++jLmqtG-j=Q-Ctr-1-GKVqYzcwOwWUF6AYHcKf5aXUSKE5A@mail.gmail.com>
X-Gm-Features: AVVi8CdKE0_TO6Y_h9SxJOdr6PO6E18SEZGrX_NJeddyc2ji01Fy-uaf4cY0jbo
Message-ID: <CAD++jLmqtG-j=Q-Ctr-1-GKVqYzcwOwWUF6AYHcKf5aXUSKE5A@mail.gmail.com>
Subject: Re: [PATCH 2/7] i2c: nomadik: optimize layout of struct nmk_i2c_dev
To: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

thanks for your patch!

Also nice to see some kernel contributions directly from
MobilEye!

On Tue, Jun 23, 2026 at 6:32=E2=80=AFPM Dmitry Guzman
<Dmitry.Guzman@mobileye.com> wrote:

> Put two bool variables `xfer_done` and `has_32b_bus` and two char
> variables `tft` and `rft` together in order to reduce struct size
> wasted for padding.
>
> Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
(...)
>  struct nmk_i2c_dev {
>         struct i2c_vendor_data          *vendor;
> @@ -206,13 +206,13 @@ struct nmk_i2c_dev {
>         u32                             clk_freq;
>         unsigned char                   tft;
>         unsigned char                   rft;

^
Maybe you want to take the opportunity to change these
two into u8 if you're anyway changing the layout of this
struct?

Either way:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
