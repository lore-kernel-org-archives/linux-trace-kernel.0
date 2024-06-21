Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A097516D4C9;
	Fri, 21 Jun 2024 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959568; cv=none; b=E2qESLW/IOT+qb3P11w4VUMDGEChApDiHUu6xLtkGCKcKpu7VUAtQ6rXzEqWmzazePUGqvN/jfb2y2XaE5MNb3moH+LXSNHaal8eFzBYDs2jG9jejZRCgPjQDZwkp3ohtmMnd9JX9czeNt6iJwrEYLEoxySjm1mMcMYNDtGP2Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959568; c=relaxed/simple;
	bh=NNmbYHkv6HvUtn9ahH6rxdw3o1BW5UA97sdx0goFbWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sh1L8t+twT8NNk9cBWpknlG48PxbegXMSJqaiLavKTzCcH/mNh6DH9RnBJ+01RD085D166XXHB2joVUh2MmW73dorsSeAOr3bFUD7DogLeZGHpl/1wtZFcVO4Pf5k6BMl5Pgy2N3zhz7xZBTVElGfFJVjD7LLyIN/Mf7UjC7MF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijp1REtt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijp1REtt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D52C2BBFC;
	Fri, 21 Jun 2024 08:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718959568;
	bh=NNmbYHkv6HvUtn9ahH6rxdw3o1BW5UA97sdx0goFbWs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ijp1REtthtpMDAjYvhmws6R5BZ4apdrdcSn1Eq3Vnh2hBgHJqJgHW/4Zd8T+51jsh
	 iRSv2Dv9x9TMFszjDUlq28Ql4/bEyh9nXoO7IJu4PSlX06lZby+pA6T4+iqqphISkz
	 MAhljr/ot3RR/vpC6ItADgDl2kVCvKo6PyR076hQvfnACDTpSWtY3gEyqpUL6JNbiN
	 Ag7Pi0NG30ONxigbA+kNAAwbrnPb/8FiDsSb8DFNQ+K1zjg1yOA3tGpNcBMyYPh9Kz
	 3Yb4VVy+o/mFtiTZd0MrkVHZLqxpXTtgpUGaBI9Ksw8ZbQl6ylv8yKuFV/m+lgzJe1
	 diG9DKKhLhWlQ==
Message-ID: <47778d62-0cf2-4c7f-afc3-a5f4d3a9a249@kernel.org>
Date: Fri, 21 Jun 2024 10:46:03 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] rtla/utils: Add idle state disabling via libcpupower
To: tglozar@redhat.com, rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 jkacur@redhat.com, jwyatt@redhat.com
References: <20240612145439.206990-1-tglozar@redhat.com>
 <20240612145439.206990-3-tglozar@redhat.com>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20240612145439.206990-3-tglozar@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/24 16:54, tglozar@redhat.com wrote:
> +
> +	nr_states = cpuidle_state_count(cpu);
> +

Question: Is this library implemented for all archs or only
intel &| arm?

If it is restricted to few archs, it is another point to make
it optional.

-- Daniel
