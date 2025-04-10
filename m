Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484C21F1510;
	Thu, 10 Apr 2025 20:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744315508; cv=none; b=CksVKgUjUES0tposoW8M3TQT4+eTkPm7PzNdluMzuqKcCnaQuBbvJ8xnPvjpoWF+ufft1AqOXNYOWUraZgI1J5ORQEJ0OXyCgA6Pb4bHVtZ7BBPyVt5mqR/0DtwS316HR3teIc7KLyjkWV9LoZT3OaShoP2lkRWaCCKhRHdLIf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744315508; c=relaxed/simple;
	bh=xB7QH4zV/fAt4x4V8OQZt+unZinWPyFzE/DZ9S08CzE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GJYpc/GhCRcYTcZ/n36pweTq7cKuFmadMq6OfNFagC2pJ3jbcLmBHuSKklJwPDIfjSDzAtlxkam6VxP7UNmPiZ/buohSm4u/rdzdKPYBguqZvnzvJcta2WooVRGpaRaLVjYPyh8wJCiGwdJtZQy49nZU4+3AVqoEmcovknpiO78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHDg6ykl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHDg6ykl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B75C4CEDD;
	Thu, 10 Apr 2025 20:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744315508;
	bh=xB7QH4zV/fAt4x4V8OQZt+unZinWPyFzE/DZ9S08CzE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mHDg6yklmXjpIP2lBpFmq7w1JPCrJyco893jnpEneeUkLfsH9yXBrLuOHirArcy1m
	 umbu8TTKoIFMjoNULXKYLxvn3dlcAZLVc9LVZ/Q25ZXwKRX6jl1L9WDGFaX4e3gKxq
	 EvlaoZyriJASeInMqsZTdklfccraC1o73hMUYnrb5YQ0r/Z6tQVdogbVVHRSDg6IN5
	 FPSMgUQM++VE0xJwH1fjY9p5BCCRxfMYKPYROSkYtKGqleIaD4NXoB63WpQWO54PUr
	 XsO6gli/s4rWyblrdq5Vzx2SGgGKxk3BAcOhw6smqhqzHu0k/KASMwv49HJmTG9AUF
	 giLEECzZQIrJA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Andy Chiu <andybnac@gmail.com>, linux-riscv@lists.infradead.org,
 alexghiti@rivosinc.com, palmer@dabbelt.com, Steven Rostedt
 <rostedt@goodmis.org>
Cc: Andy Chiu <andy.chiu@sifive.com>, Evgenii Shatokhin
 <e.shatokhin@yadro.com>, Nathan Chancellor <nathan@kernel.org>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, Palmer Dabbelt
 <palmer@rivosinc.com>, Puranjay
 Mohan <puranjay@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,  Alexandre Ghiti <alex@ghiti.fr>,
 paul.walmsley@sifive.com, samuel.holland@sifive.com
Subject: Re: [PATCH v4 01/12] riscv: ftrace: support fastcc in Clang for
 WITH_ARGS
In-Reply-To: <20250407180838.42877-1-andybnac@gmail.com>
References: <20250407180838.42877-1-andybnac@gmail.com>
Date: Thu, 10 Apr 2025 22:05:04 +0200
Message-ID: <871ptz940f.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

(Trimming the Cc:-list a bit)

Hi Andy!

Andy Chiu <andybnac@gmail.com> writes:

> From: Andy Chiu <andy.chiu@sifive.com>
...

(Oh, if you send another revision, please add a cover, so it's easier to
comment around the full series.)

Thanks a lot for doing the lion part of this series, Andy! With this in
place, *finally* stop machine way of text patching is past us, and we
can move RISC-V out from the 20th century. ;-)

I applied your series, and Steven's series [1] to [2], and ran that on
QEMU (riscv64, ~RVA23), and on Milk-V Jupiter (Spacemit K1) with:
 * CONFIG_FTRACE_STARTUP_TEST
 * ftrace kselftest

No visible regressions, and now the ftrace kselftest can actually
complete! For the series:

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

[1] https://lore.kernel.org/all/20250409151549.788068911@goodmis.org/
[2] commit 3b07108ada81 ("Merge tag 'linux_kselftest-fixes-6.15-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest")


Bj=C3=B6rn
