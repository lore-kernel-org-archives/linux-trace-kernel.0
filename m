Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882900;
	b=S0Fv1yTkBEpcW1yAarnAU4o/fEAtX8qSSYZR3XpTaeqgQ1fjGvxBbS8q9KLUmQXeBwZS
	 7XB3zOxsWCTc+LM+Er2/+xHXVgfB9hHYM1yJ29YSDfmUhquwV7rYX/4FmWicbB+A50etK
	 Fkm2YKspzrpIebn5L4Ar1BgekLo+FXUJ7QozTibgnFmJFEWI3qHDC4IsL8NXopqJ2Bino
	 SiOEXZeEB7n1F2OwINJzGS0ZVAZj36OfzGXyjIBu17drFVMuVrXgSmG4oNEq5eM36STml
	 iVu7NHEjBc7CocJyV/Nv6o0rzY4q7DEJaiXwS6zKKIBT9COPoGqB28vacuPL5rtWRmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882900;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=CeBw+s2LvMeqG/vb2nuXePt6wR8Y9lUm4clWyu7tZNY=;
	b=4VzngWyIsfhNbuJU7/R28Ww5aTn6xxEn8brJWiwnAZ1g5DVx9hNZdBClYL7yTM8QrECB
	 9QcmI6yPrCfQsGzKQCVzLDNczMNV9bm5Nz20ySzuEpbBJ6qgp7MX98FxK311L2iA+k5WZ
	 44x+ZbZ/zuzrRxAn51zeCHTPjTQM/t9Ljrh/5LLEflwmUzXnz/QFoNqSR7Ur59B8dFfaT
	 gImlPBwsyYO5NfnBabSwWRHobLPAmosCORBafK7TCOXKO+OMhv10qar0aPxsLWWI+HOzd
	 fiN0wod41l80D/kXWlw5HpkuzsE/DZ1e0P41a6x6WStQhWZY3y4G40GU24Si6RjrlxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIldk2Cs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A5F606A32D;
	Thu,  5 Nov 2026 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIldk2Cs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1F11F00919;
	Thu,  5 Nov 2026 12:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793882899;
	bh=CeBw+s2LvMeqG/vb2nuXePt6wR8Y9lUm4clWyu7tZNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AIldk2CsQlorkpHASsofuj2utGYZeupCKR07f2JeNTZhwNllI0w3n4vBScSUWISUR
	 kWvqw0mbm73nc7U5eGM3r4OZz4iEO8RcMgt2Ytx6TVAyQxKP6Yc9P55jGHy0CWFQA3
	 pGeETt5FIAJXShO5uaEoh9wHbn9TgCRVRA/nT+yTAYj0yizEVok3BI6q74VXDmp+hE
	 0J4YcTRvwPNnx3VC1DZ0R/t8K1hzumaozg/yMf1fWht9tsHcpW2J7uKScggTfISm0d
	 PJfhyy5a8yrXHGHk8RMCgpvJEhIrfM2SM5FQWmaBX5YMeygPOfOt8Y+P47M1dphDCK
	 Lvrjgoj8y8VcQ==
From: Sasha Levin <sashal@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	linux-trace-kernel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/user_events: cast pointers through uintptr_t
Date: Thu,  5 Nov 2026 07:48:17 -0500
Message-ID: <20261105124817.1532094-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105110333.0fa21741@pumpkin>
References: <20261103163913.640876-1-sashal@kernel.org> <20261105110333.0fa21741@pumpkin>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Nov 05, 2026 at 11:03:33AM +0000, David Laight wrote:
>On Tue,  3 Nov 2026 11:39:13 -0500
>Sasha Levin <sashal@kernel.org> wrote:
>
>>  	reg.size = sizeof(reg);
>> -	reg.name_args = (__u64)full_args;
>> +	reg.name_args = (__u64)(uintptr_t)full_args;
>
>I'm sure you can't need both casts.

It works as is, but you're right, the assignment widens the uintptr_t on its
own and the (__u64) isn't needed. Happy to respin without it if the maintainers
prefer.

-- 
Thanks,
Sasha
