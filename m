Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793452031;
	b=yDJl6HrJoyrnzhlyuOoxlssgj2KiJk8+lS76kLs1MbU03HuR8kP1tVee40By4H0uaGlw
	 CmjznqlfcaLTaFLb1JjYRWay4at6i2QSvvOxYUPOkv2P1vyZWng8iKLbYyeWeJF0kGci2
	 HNt2tH962nxJ83t9FPmeu3r0osSoLqRV/7CVj13RZ3uKXTSns60hbX9eKRoPDMePfE5Bj
	 3sBvcxu/leq5RoXElRv2Uwn35ECH5jtyIS8ESBK3gQwfB7tTNNiKiN3SODhCwLUsljb0U
	 xbhKTj4jo3G228H5o2Pxbiwf+L9EKU5jBBrsT5pF08YJGYw2IKdniCe4+YTnJnIF6yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793452031;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rvdPv4hRvTf7pVG1n6aNMYDnMjBNHKJfM9FYI7MvNRU=;
	b=mmYn8Htxr5yFRb94+czYzraUB+rFDIzGDJpea1UZbPKOTE/D3PPBLSiTk+rNw2CJEA3G
	 gqcwCdnKk9D3c912NDQYu9cdnTmo6gVJhJZTVWix1qaFL13Z7pIGiO09Ru7i9vDeWNJGM
	 vkWvHWpCN8wWF5156xlfiwn/xngk4NQZo0ofb7/Zy6zcK53Jf5bUgNNeBRJHYAQHtMln4
	 fjVSG+7Kab+QPwIA8IM57noP102OE04C/Si7gSzzRge0pXHZ3PqaHxqNnXOd2iS5u+bzU
	 NJtHHXsXgQp2M/5Z/ziMdHdjW3aeSNoHQOt9AGHsXR4HE4OIdlBKSLI1snYO1NqLWLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DKoXxjoi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788D9606A31A;
	Sat, 31 Oct 2026 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DKoXxjoi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AE51F000C1;
	Sat, 31 Oct 2026 13:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793452031;
	bh=rvdPv4hRvTf7pVG1n6aNMYDnMjBNHKJfM9FYI7MvNRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DKoXxjoiV6quLf3es4UT1I3AzJQI2dmDLtMeemLY1n2qSpH6C9y0eMmNJIts8/Y4a
	 Gf9DOO2dB4dL97eTVr3PBUfxUOe6Cf78kTqslJNKaPCQB/lSxXJsDCE6qytwLF5OYG
	 PdVa2ftyQEf9fuqtHBEI3nvdIjxDBgKlEz0IuoxfEpwJ5vKVBteAp1s7GTzvBZgwq0
	 GBjUi6LFM9Yc43z3U+mks2pPXWL2OGb1mzZo7Rg5X2pTvIextOtQ+tveX2TjSa9hak
	 dH7x38IPVNsGt+6tz8xT0CS4s92CXMF4S2Kj4RU8SX1es9ZUMJg4cNP3f3lIenBlcb
	 lBZ2YVY05V27Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] tools/bootconfig: Preserve tracing settings during export
Date: Sat, 31 Oct 2026 22:07:08 +0900
Message-ID: <undine-1793452028139689664-4d0bf20c02a1c855@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <cover.1793442331.git.edumucelli@gmail.com>
References: <cover.1793364709.git.edumucelli@gmail.com> <cover.1793442331.git.edumucelli@gmail.com>
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

On Sat, 31 Oct 2026 11:25:30 +0100, Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com> wrote:
> Hi Masami,
> 
> Thanks for the review. I've updated the event-filter patch to use the
> explicit delimiter pattern you suggested. It now warns and skips filters
> that contain delimiters and both quote types, since bootconfig cannot
> represent them. The other three patches are unchanged.
> 
> Changes in v2:
> - Patch 1: use explicit escapes in *[,\;\#\}]* for the delimiter check.
>   The semicolon also needs escaping for the shell to parse the pattern.
> - Patch 1: detect both quote types, warn on stderr and skip the filter.
> - Patches 2-4: no changes.
> 
> The series keeps event filters, generic trigger counts, histogram
> variable ordering and paused histogram state during export. It is still
> based on bootconfig/fixes, including the two fixes you picked up earlier.
> 
> I retested the filter change in a temporary tracefs instance on my Ubuntu
> machine, running kernel 7.0.0-38-generic, with recording disabled. I also
> checked the mixed-quote cases against real tracefs filters and added
> regression checks for both quote orders and all four delimiters. The
> fixture checks cover each fix and the full series.

Thanks, this series looks good to me. Let me pick those.


> 
> Feedback is welcome.
> 
> Thanks,
> Eduardo
> 
> Eduardo Mucelli Rezende Oliveira (4):
>   tools/bootconfig: Quote event filters in ftrace2bconf.sh
>   tools/bootconfig: Export replayable event trigger counts
>   tools/bootconfig: Reset histogram variable tracking for each instance
>   tools/bootconfig: Preserve paused histograms in ftrace2bconf.sh
> 
>  tools/bootconfig/scripts/ftrace2bconf.sh | 29 +++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 1dc6d173c43e10a1d0ee36b43d0d2f371f4d262a
> -- 
> 2.53.0
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
