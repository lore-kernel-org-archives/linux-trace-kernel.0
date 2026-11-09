Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794225958;
	b=Mvq/1akp7qXyq4McwZAnBhDQyyNu0ss2M0l8Wyub0EzeD7myQO7oq7LATUCsQsEeK6jz
	 CTukAOXVpnd0o6GMNp4hMYPX17MC7e1h6X1kG+6V1QihrwlpV8mtoaWXBixk4IKk/AMLC
	 xtiYGF57q+LU9+3kxYI7tGnC2XKJy9mzR2QvfirM7v9n19T5bVcmb+DzXdMDLFTriYknK
	 cGgfFzymyFlscGzkyHfQ03yDHBRjg8QAoQguMZbqqYYPK2lR91LUuPWE3Sofe9YWUtqAN
	 +2vPKR/tOC4vcpLAN54kZGqC9RCn6fG1r+5/WHrTXySRn6jZ1K6sspeLPpnhjJ0hLKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225958;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8VRMkBgMeSqbC5Ba9NzzAeWALgbw62uujK7fDusMRS4=;
	b=yc0AoUSKCWkMOqEDdjJFUvMch2A9uaV8thJTUkkPBhYQyqpR+1/t3ZTQELub7on6WV3i
	 /Np3kaOL5E28WHN0Absejgto7hpCkrnjt5WteO7fD5Zfml5vmUXIhcubI2hJTbrzdF5MA
	 NBIOfQ7oTbnlFqQ0HK3H0QA1NWzR994JbCjU6M/cBteW7rf4XABY1iAAJS7jgHBJlELtN
	 m5X/M6PXM3ZlBDbmQ4Qjj2IFu/26R6NZL/6UPVRqt3AU6sueI598jXiIbejEXQrHyn8X7
	 K4UOtgvgS0fAxwsza05XcHElvKxsISc67btruvpfTYe0eAvZRzEJv1xpKbsq37VV0JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rw1a3E63;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEF5606A31C;
	Mon,  9 Nov 2026 12:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rw1a3E63
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629461F008A5;
	Mon,  9 Nov 2026 12:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794225958;
	bh=8VRMkBgMeSqbC5Ba9NzzAeWALgbw62uujK7fDusMRS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rw1a3E63im1BPzwPFfjalYxnWinbwVrJ62OeoygdnT6Wm3B1HUdFpvPuG6jop+GKW
	 ozvlWkMdFnEoobD/CbcU4A2BrMZFSgk+84DPWhQWs4wo3MM5nQtAQxl582gIe1C/JZ
	 lvQMYtluZuWWRJAcLh/PR4o55eGykZBBJIDX6O8h6nSroU5kn8dNcWzmZgusb5DDZC
	 PkydHofWFJcIiaUYSJIEmJr+yQmWJd4NVZDKzvYDRC54ZJ9GEuH/EYdqRVDdsNLRM6
	 +TNJSQt10EwgYUIDY3u9HLdQfWeZ7GczTYJBsqJE86cHbG6q1XAOklOWEgckospTQ4
	 Fv75q+aFIzEEg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, "Linux trace kernel" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] riscv: kprobes: free insn slot in arch_remove_kprobe() to avoid memory leak
Date: Mon, 09 Nov 2026 21:05:54 +0900
Message-ID: <undine-1794225954481525621-8248ce0c28df01fe@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261013023605.317-1-yuanxiaofeng@eswincomputing.com>
References: <20260731100940.2330-1-yuanxiaofeng@eswincomputing.com> <20261013023605.317-1-yuanxiaofeng@eswincomputing.com>
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

On Tue, 13 Oct 2026 10:36:05 +0800, Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com> wrote:
> When a kprobe is removed, arch_remove_kprobe() does not free the
> instruction slot allocated by arch_prepare_kprobe(). This causes
> a memory leak every time a kprobe is unregistered.
>
> Other architectures such as arm64, x86, and powerpc all free the
> slot in their arch_remove_kprobe() implementations. Add the
> missing free_insn_slot() call for RISC-V.
>
> Registered and unregistered a kprobe on kernel_clone in a loop
> inside a QEMU (RISC-V virt) guest: before the fix the number of
> kprobe_insn_page entries in /proc/kallsyms grew by one every 512
> iterations (each insn-slot page holds 512 eight-byte slots), and
> after the fix it stays at 1.
>
> Signed-off-by: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>

Since this fixes a memory leak present since RISC-V kprobes support was
introduced, please add a Fixes tag (and Cc stable):

Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
Cc: stable@vger.kernel.org

And

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

from kprobes point of view.

Thanks,

> ---
> Changes in v2:
>  - Drop the stray blank line before the closing brace.
>  - Extend the commit message with a reproduction/verification note.
>  - Rebase onto linux-next 20261009.
>
>  arch/riscv/kernel/probes/kprobes.c | 4 ++++
>  1 file changed, 4 insertions(+)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
