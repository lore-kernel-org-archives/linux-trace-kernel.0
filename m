Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB612D0631;
	Tue,  2 Dec 2025 18:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764699188; cv=none; b=TF/yeXlVwoiUxYwTY4ny3wjSw+iujF8fNXYPzs3Li6CxW5XWKwDYqdSY3QoJX/H7E3UNAwB48+nZxhA8OoBU79XljIcxpsHjgUQ47H5g9ZkdJ0I3AK3O2ZxC4KvZdTYVpOGcS7HGlfXzsV3bR7sLITBsvPk/6al9QioNQqbRi44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764699188; c=relaxed/simple;
	bh=BPuDO6euQjcqeEaBFpHRW5ISfxtqe0QuSO1cQRiMupM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fa10mF4NyC+ByHVwo+RUc2+dHdm4ICVbFPl6J/xhZRM01VVJg277aGfIXxJunrIJ9NiWua3dg++PEjU+bg7zQ7uRP0bFaE3QvDSp9qwz0NhbRNUxH9p/xxKTpThmrNfmohFXr9iFwycdVO++5z0YoDrPIL5HKLjj1dlc9WlFzqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j38f2CD+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j38f2CD+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B417C116B1;
	Tue,  2 Dec 2025 18:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764699188;
	bh=BPuDO6euQjcqeEaBFpHRW5ISfxtqe0QuSO1cQRiMupM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j38f2CD+G1vyN9Y+pm8geZuxvTuzVHLKtlzzNULmeUkplZdW8nS8IBHhg2YQvRDuE
	 b2jsbpv3T30CwRLX3U0Q39oVfk2/QnhPtZJgT/hwO8VY6ZqXsigiTc+fnEvCVQl1o1
	 w/GlzY7IzbEqxMcOmdlKZlE/IXolCsRcEoqHLrSo47vfMM1LnoxNnZz+8f80EB20ix
	 gFQ8/wQ63NHv3aWyDfVVNSbDUeyCNN19rHUe3JLVurMK6CYa2fnBxhkjFN3K4JMS86
	 sSKmGihq9O+QjFQuHVrdp82TvhaiHNPRg2+RaG9SdsazyFxrbwFLy+97DKaicjwbow
	 s23qo5wUuvHGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5ACF3A54A3A;
	Tue,  2 Dec 2025 18:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: optimize trace_f2fs_write_checkpoint
 with enums
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <176469900752.3331097.11163063452209234424.git-patchwork-notify@kernel.org>
Date: Tue, 02 Dec 2025 18:10:07 +0000
References: <20251128032509.825003-1-yhli@google.com>
In-Reply-To: <20251128032509.825003-1-yhli@google.com>
To: YH Lin <yhli@google.com>
Cc: yes@google.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 linux-f2fs-devel@lists.sourceforge.net, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, jaegeuk@kernel.org, linux-trace-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 28 Nov 2025 11:23:57 +0800 you wrote:
> This patch optimizes the tracepoint by replacing these hardcoded strings
> with a new enumeration f2fs_cp_phase.
> 
> 1.Defines enum f2fs_cp_phase with values for each checkpoint phase.
> 2.Updates trace_f2fs_write_checkpoint to accept a u16 phase argument
> instead of a string pointer.
> 3.Uses __print_symbolic in TP_printk to convert the enum values
> back to their corresponding strings for human-readable trace output.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: optimize trace_f2fs_write_checkpoint with enums
    https://git.kernel.org/jaegeuk/f2fs/c/a7982944b487

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


