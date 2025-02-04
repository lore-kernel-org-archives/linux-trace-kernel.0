Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65C1215F73;
	Tue,  4 Feb 2025 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738674557; cv=none; b=LDzJvOcBBHbT5FnjJ22YPihbS7S6Id8G61XxUqLrp4L4eZGirR2PhJ7gora+xvBvayJREgRtDby200fMqaSmV9SuoBtNbHrjxNfgl9gOTfT8TeQ6shMRhQL54CAcz4OlhztGMPmaMHL9iC2naQkAWHwodow+QvTW1AFlpELfaNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738674557; c=relaxed/simple;
	bh=vxDHz8ElI6Ex4LZgJZ8U26irCHGknU34NH8DsZG5iSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTQErrF9VDOX8N4ZVoqj69lZ8IptIiTVhdVL6FJCASXeoQM0/5kU2ETWP7LlvvA25ZcAkvOwnYyBcpoqUzh8hE9Quw7GsAyitV6rIEKt+cMdMjbJjZ2IKdPwmtqkdfvIYmoabbd5KoVdlgkYi7rU/gCu+eH5ia6kcl3n2GEj+FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqHji4ei; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqHji4ei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DF9C4CEE2;
	Tue,  4 Feb 2025 13:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738674556;
	bh=vxDHz8ElI6Ex4LZgJZ8U26irCHGknU34NH8DsZG5iSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NqHji4eix0w461AuS2feo2p8tgbNje2wDxWa5HEF7d/NWCIACk2U+fLFn8wTQHWie
	 Uhl6zZgZwS5LNVBtLAQawJyfwqde116QD9uoA8BxmvPwOanf7KMdck1cnwicLTd5G0
	 MsxFMpPa0iRi5EXCFbpdSQGdjjT6A/TL1RZbHfz3AYmfvpB6P41kR4fOUnWA9uJQx0
	 80SoXpiJD7mZDemrmta/lJLIpExMSROUootZ7GCERtJUit1hC0YDCM8l+nMq32U1/N
	 einegFkb/GDssWWEuFTZGTvT6CRKrBnZj7oAJwa8Dx2iu9sBESZf5BVu1wBP8N2+bE
	 +TBd+rkcwJF7Q==
From: Will Deacon <will@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	Lukas Bulwahn <lbulwahn@redhat.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] arm64: Kconfig: Remove selecting replaced HAVE_FUNCTION_GRAPH_RETVAL
Date: Tue,  4 Feb 2025 13:09:04 +0000
Message-Id: <173867195188.3988698.8446978312627999775.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250117125522.99071-1-lukas.bulwahn@redhat.com>
References: <20250117125522.99071-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 17 Jan 2025 07:55:22 -0500, Lukas Bulwahn wrote:
> Commit a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs with ftrace_regs")
> replaces the config HAVE_FUNCTION_GRAPH_RETVAL with the config
> HAVE_FUNCTION_GRAPH_FREGS, and it replaces all the select commands in the
> various architecture Kconfig files. In the arm64 architecture, the commit
> adds the 'select HAVE_FUNCTION_GRAPH_FREGS', but misses to remove the
> 'select HAVE_FUNCTION_GRAPH_RETVAL', i.e., the select on the replaced
> config.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: Kconfig: Remove selecting replaced HAVE_FUNCTION_GRAPH_RETVAL
      https://git.kernel.org/arm64/c/f458b2165d7a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
