Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793319946;
	b=NdMeGyz6Oo5WaZLreQ/wmrrAwld0u2p/NicAAmpdN7/YropMOwhX86Eh9WmJPwWn00s9
	 a0iJr1Y/9cjdzJf/w63P36ylY1B/CHGXm0TcjpzOt50qD2VkKHt29esKemwDsEQ6cmlFR
	 WiDDQurOk7xBrTNIHEdLPmu8y6Oum693FOsU/BTjvP7Dgbe1bwIz6CzisKRLPJU7IzVLZ
	 dI7LHdOWfFNw139wfim1hVLVII+UFNV4WdsNaRvCrfdpt/72c5lNPcIM9thUYdJYRWbxL
	 VdEFni2JuDHf1KyfrmoTGC5pMrtKmAoQW0pIQJLD5YL+E0HMAQAUQiTUtblGFkSF5Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793319946;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qP6txxYxHIOuni8rk0G70MnVHBk6GxWVohudndyBeaQ=;
	b=m2LWZIIi98qk61I9JMcKwCCcJbIEh5RgT6ZOxOUbhxWXy2j+2fl6vU9QhKmH8QyyNiiZ
	 0gJbpBEtszAm6s+zKoreFQsfpldF3EmQdsLIPtP8MdMOng3jPRa3m3gkhvHQyPWh6DhNw
	 kZUclPxiE5uPQrCYWydjHYoMIp7iIRwSXgP5wkzm/CIhUV2+DZsRtJGypfMzKbu0WHACw
	 VHr1argtBNvnYQCyYuTzCF836S4KKYmlZKZCi8944XAP7bkW9mwyHkU8ZBM9SATd2sJ9O
	 4bykGmUngpQ2kykFXErtYxPdCOXCTRTgEDdU4WZcia+/Qz6HqMnB2Hjs4yiyTLvT/9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nGKW+Iwz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C555606A31A;
	Fri, 30 Oct 2026 00:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nGKW+Iwz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCBF1F000C1;
	Fri, 30 Oct 2026 00:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793319945;
	bh=qP6txxYxHIOuni8rk0G70MnVHBk6GxWVohudndyBeaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nGKW+IwzAWaRrOG3+GTk0v/DR+fjwhnpkL+Ct+dczrGFLskCoxsjcuRwWkhGd99SL
	 R2gdEgglNxM5XG8RKmtNd6LURPv4J0+7RVphkox1milR09x40faaxEyrryoqGdYnGN
	 xiOXWfNGsMHfLpDzMwE5yjJh8xgOw17aIwiDjE1miMVCayHyDKCKNVqK4oxSgt8RsX
	 zOXpzWkPhL8bgMeQBFd3RVIIEF/cAVCFR3210iU1LdEpfWSO2DBPQq7ggHKgLfHmRg
	 SVtwoeWEeWS+nNANltQUw/RT/jzoFtSwlRgFaoHSIcVQHCCEFfVqW/bgD0bP8Qiahl
	 e/qw8i/dAKsdA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] tools/bootconfig: Fix histogram filters and variable names
Date: Fri, 30 Oct 2026 09:25:42 +0900
Message-ID: <undine-1793319942513765724-cc2757c235ae029a@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <cover.1792949723.git.edumucelli@gmail.com>
References: <undine-1792936915899334889-d965251e73c20670@undined.local> <cover.1792949723.git.edumucelli@gmail.com>
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

On Sun, 25 Oct 2026 18:35:22 +0100, Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com> wrote:
> Hi Masami,
> 
> Thanks for the review. I've combined the two fixes into a series and
> used the two sed expressions you suggested.
> 
> The first patch keeps filters when exporting event triggers. The second
> handles underscores in histogram variable names, so the exporter keeps
> histograms that depend on them.
> 
> Changes in v2:
> - Send the two previously separate patches as one series.
> - Use separate sed -e expressions for [active] and [paused], avoiding
>   GNU sed's alternation extension in patch 1.
> - No code changes to patch 2.
> 
> The original submissions are here:
> https://lore.kernel.org/all/20261023084947.3264289-1-edumucelli@gmail.com/
> https://lore.kernel.org/all/20261024110837.696216-1-edumucelli@gmail.com/
> 
> Feedback is welcome.

These looks good to me. Let me pick it.

Thanks!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
