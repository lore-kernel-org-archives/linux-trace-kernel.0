Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547284;
	b=Xav6HnZTz9/3D4v2+js0ViRYvbUik+m5stxtMVvGYkVzDH2xNOzh8ZW6d1WQVMwlKesJ
	 rNDlJpqhzrvM0ytsxZhHrGj0yPsngF/fKDONS7nxc0qnKizb5edgJXDq7FGl1vj4NjQBH
	 00Qi+6VeU/GKukQTVy/ahAAykzAFaFMl7D7q3W3KcCAuMpbVhSmU/t0xgPUpPJnVYIDJY
	 A/75BNM/T2WxgcCcSrKkIzpwhKzaKFFuPCHXKySDNqGw9Idp/DpBs1WR2GbizcazuFhOF
	 1mpq4KkWf87MElsgrUdnyGtvQWLAA03O4sB3EfdhiU+a96nTUDymq0mWHYLE0A7wBbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547284;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=R06Lc1M1W5ZQ8oC4WeetkwU3ADGXzvHxpZst1AbqPUs=;
	b=JxMxV7aCkf5439Eze7z4EDRZlkUb1Zlu3gJ2xvhHYP1AwzqFqeQ8ofS8cIMe7u2JECWU
	 ZgI5A7cuMT6Lf8rnnZ2iPOZn+SKeRBLJbJZs95AIR3JJpbTyDv5yyY2GmQuL8leUVLKfo
	 ZGa3pGj/C3dHUd7G6hgf3wDiDl81gHYerICYSu0QDvWyUFfuV6Fp/3xN956Kf7d1HaGdH
	 19ti9Utb0l2OHPvgIJOQK3tmXiGYSX1B/hRnluBmJgJqLUPDOtp2xAuOg4FJs5C9fJLBY
	 Yaok0A6xHFa+vnVvhmB+IbFxmgA+k0QG+p6Qg2JXedH6/SJlH0Z3eKVWLymITf9QebQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0CzwWYM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643CB606A31C;
	Fri, 13 Nov 2026 05:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0CzwWYM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBFC1F000C4;
	Fri, 13 Nov 2026 05:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794547284;
	bh=R06Lc1M1W5ZQ8oC4WeetkwU3ADGXzvHxpZst1AbqPUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W0CzwWYMMHVhq0ppIHv7CJ7Nq7Yb1ojQEIkYQUnhrOPIu7pcAHdDl/4NTBL0MixS8
	 8nbRzlKPZ91nhlxqLE7JTOtdYXipe6CZmqx0jLIaeE+S4aEh1iDVEQ6kwfE8lTCIWh
	 +JP4TWRh1nZH/A+B/hBn6nNFPVPtdeA0jOxH7Bo6iP5GP7k/gHxtzpNuHdEZG34GJ6
	 zoMXq73x+wNvnKKNSXE+O6rx28p7KmFEy6RPfZ8Bvcd1vSWoyEY/txypWCXAXuQToM
	 TLk2SmoZcFInGyzJiSwMnUDCiMsUft24Ca8PpyxppZZCDD4cJBX+7uKV3FLgd5ZkCv
	 W6mO1dQIAJy6A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
Cc: akpm@linux-foundation.org, rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] tools/bootconfig: Preserve values containing both types of quotes
Date: Fri, 13 Nov 2026 14:21:20 +0900
Message-ID: <undine-1794547280843201319-34d0935dcdc44d3a@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <6ad95c1a6eb524143a38ef9a0d4fd87b92ef1daa.1794337724.git.edumucelli@gmail.com>
References: <cover.1794333957.git.edumucelli@gmail.com> <cover.1794337724.git.edumucelli@gmail.com> <6ad95c1a6eb524143a38ef9a0d4fd87b92ef1daa.1794337724.git.edumucelli@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Tue, 10 Nov 2026 20:08:47 +0100, Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com> wrote:
> An unquoted bootconfig value can contain both single and double quote
> characters, for example:
>
>   message = He said "it's fine"

Nack, I would not like to support this unclear value in bootconfig file.
It is OK to *detect* this kind of mixing value as a wrong value, but to
support this, we should support escaped quotes and force user to quote the
string.

message = 'He said "it\'s fine"'

But is there any actual usage for supporting this syntax? I would like to
keep the bootconfig as simple as possible.

>
> xbc_show_value() surrounds any value containing a double quote with
> single quotes. If the value also contains a single quote, both compact
> [...]

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
