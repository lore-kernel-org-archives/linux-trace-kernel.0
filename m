Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4292F8EA2
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782341643; cv=none; b=ju6+AUvoph9JBcR+ArSy/g0zfS1k1+bExWS/wX5nvQkjQHGIg4FEPTmArBrm0ALghb3zJHwSZdUOThi0kSDz7NNGSX0sQf56r5ZurrhAB2l2Ng4vJJEsphlXJhVbKM78Z6rulh3jFY9jVn4XCyp4skIzfACf7vHGxCgpYNYYg9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782341643; c=relaxed/simple;
	bh=zpOCuzf+G4s0AhornyImeV1wnkb/qeiYYlxslZLliek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhyQ+V31fqAAF1fbaW+7XjzmAhukuFONING9OVUrtZPR+GdeJXl3Hbg5BkNShrTq7tbMrg2bbvuGJrbFIeINCQ9dN/iAGokdWjMZ8yY+ntEK/X2IxhuvKjuCRJzzM5KGGuse074dpc/+ByA7V2Scf7lTYNpSxxvRTKqxEyPz2TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrCTfmBm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrCTfmBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8A11F00A3D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 22:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782341642;
	bh=tEQluaUQHs9Pq0sF7uhlZdeGFpXYplo4f7PQqgQuW+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NrCTfmBmThM1e1ywz4Uc2cTJ5NMszbpwARgHQLTV5IT7dosoyM8EUug4ZdRHO5vBK
	 GxpbLJbPi0QS9POiBYLdSqQHSwagUc95L5+eHC9YaRepFTw4TqVg4NL5pqMrpN3M0u
	 vMMRf/yOye5AE75iet3ERfBLDcDJalgtwIJfgN4o8bk1oDn03I2rUgTbmUSKCHYK4p
	 rG9IfM+BtV7n1peDjDY8N7kqYHjYJ66BZWJ4/eLPSa6k5AkqjxWmQ6fyTP9rFuq07Q
	 hcS7eC4wLX+nvvotyiW0JjXfzm9BSj6Cn6TCV8QoQC5FEI8TS1yk1e0mOD2XxACIyo
	 Sq3/JtDJpwGbw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5ae9fabd40fso362176e87.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 15:54:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp2jPbBNzfHrstkOMtf3BBMNK/vIQfXCcBpWncWsFqEPGduCZgRZy4IniHlMh5XN2utloCMUsIdcZ4Cj43iV6tMCWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyED1PlZnIpJTfSiM1dDlEXd8qRvdEsYr77ulsU4XzFXqMaF+pf
	53d/3G1ymNYuVA9iZwF0acX2XDzsZS+AzWhHIV2dlVmHbXyXzAEvGhNy0ImJKf0o0boLSw09S9K
	dqdaLdxO7vWWkSR55nW1n0NWD0lawong=
X-Received: by 2002:a05:6512:8355:b0:5ad:58c5:5d49 with SMTP id
 2adb3069b0e04-5aea1f2939bmr10018e87.5.1782341640926; Wed, 24 Jun 2026
 15:54:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-i2c-fault-reporting-v1-0-6db1a8aabf18@mobileye.com> <20260623-i2c-fault-reporting-v1-4-6db1a8aabf18@mobileye.com>
In-Reply-To: <20260623-i2c-fault-reporting-v1-4-6db1a8aabf18@mobileye.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 25 Jun 2026 00:53:48 +0200
X-Gmail-Original-Message-ID: <CAD++jL==oidAtZRLkp6GS8zDj_HzVYiKK4ySiXtLGBjevY=vkQ@mail.gmail.com>
X-Gm-Features: AVVi8CeRZhi16rK0R8T_l8f30fSkRD317i9RKDpTB3E_lRbKkea3D6tIJrIzIIU
Message-ID: <CAD++jL==oidAtZRLkp6GS8zDj_HzVYiKK4ySiXtLGBjevY=vkQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] i2c: nomadik: return proper fault codes
To: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 6:32=E2=80=AFPM Dmitry Guzman
<Dmitry.Guzman@mobileye.com> wrote:

> I2C documentation Documentation/i2c/fault-codes.rst defines fault codes
> for different negative results in I2C transmittion. Previously,
> i2c-nomadik driver didn't implement them properly - it returned
> ETIMEDOUT on most errors and EIO on master arbitration lost.
>
> To comply with the documentation, return the proper fault codes for
> different conditions, namely:
>
> - EAGAIN if arbitration lost
> - EOVERFLOW if message is too long (>2047 bytes)
> - ENXIO if target address is not acknowledged
> - EIO on other errors detected by controller (for example, NACK on data)
> - ETIMEDOUT if driver gets timeout waiting for message completion
>   without any fault condition detected by the controller (for example,
> too long message, or SDA/SCL line stuck on 0).
>
> Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
