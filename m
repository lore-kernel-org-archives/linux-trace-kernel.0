Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACA4208C4;
	Fri,  8 Nov 2024 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731084597; cv=none; b=hc30gcrUItijM/LfuKYby1muQhiTGpE8jGToXt4f8JbaPz+QAMBHND9xYwgtsuonG0pp2ABl8EfmGek1eoh8PmtV0Y+7ejPi+vK+5REhPkrj5VhMO4G1M2HqFk4LCg1GIUh5LaamK4S3RXZJ4ajJSw/1o/y/xEHNXK0QkglBVek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731084597; c=relaxed/simple;
	bh=cXPrjrpjuZPxx0TaEQDXRVhDYd6V5RMoLe0vUwhyI3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6o7gWxC9ygyDz484infinvU/WhXr2CI6bCc03U/xQIbR5+yR1mCGG6E1HaAucSHufqFxJHeQYs9/zI58N+dufE070v2cGe2jVsHUFeGiSS8RmQn2JWoNBjzXfphEF0EakEJ106jHRYVJpjyQYYK8WowkNnvCs6vudxd04VGda0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7E4C4CECF;
	Fri,  8 Nov 2024 16:49:55 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	mark.rutland@arm.com,
	Liao Chang <liaochang1@huawei.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: uprobes: Optimize cache flushes for xol slot
Date: Fri,  8 Nov 2024 16:49:53 +0000
Message-Id: <173108456812.1559945.17269799494713828811.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240919121719.2148361-1-liaochang1@huawei.com>
References: <20240919121719.2148361-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 19 Sep 2024 12:17:19 +0000, Liao Chang wrote:
> The profiling of single-thread selftests bench reveals a bottlenect in
> caches_clean_inval_pou() on ARM64. On my local testing machine, this
> function takes approximately 34% of CPU cycles for trig-uprobe-nop and
> trig-uprobe-push.
> 
> This patch add a check to avoid unnecessary cache flush when writing
> instruction to the xol slot. If the instruction is same with the
> existing instruction in slot, there is no need to synchronize D/I cache.
> Since xol slot allocation and updates occur on the hot path of uprobe
> handling, The upstream kernel running on Kunpeng916 (Hi1616), 4 NUMA
> nodes, 64 cores@ 2.4GHz reveals this optimization has obvious gain for
> nop and push testcases.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: uprobes: Optimize cache flushes for xol slot
      https://git.kernel.org/arm64/c/bdf94836c22a

-- 
Catalin

