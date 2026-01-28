Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D1F37107A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Jan 2026 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623541; cv=none; b=oNgqKvyuYx5d+jhEPyJbOdyLmD2EC+eurJ/F6hAq+sI6W7OIdk8UC8fpEqgDBgJdO47aIUYpQo0pxxiz+XkfsSWl4csyDDJbNNrhRbmnXf/xnbvCPHVoAqMnmrzJgKainBK9AYNZay+ehyhac3A992hZNXB7dWEfLtI6F7ogAo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623541; c=relaxed/simple;
	bh=Z5Y0ypxvByBYwjX882uJ7Vj1LBD1G57O7acbyz/bNg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Izqk8HwqAgNTKWJmTPqjxSYdq/qMYZ3wL+0zGmMZT03tfjmO67Nz8is0CDfh65CuAklmwxheg7eaFx1zGLqyoG7h8n5hfefAgDNPXD3n/EoP1XCK6j0xgc0uVWxijHRrz8HajrzKR7tHG+8uoX5Z1QgECC4txrdgwSsIBicODqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=l4Y2sqLn; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="l4Y2sqLn"
Received: from trampoline.thunk.org (pool-173-48-123-50.bstnma.fios.verizon.net [173.48.123.50])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 60SI5INC028707
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 13:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1769623520; bh=HUdpk//KLYaWaJDXR2jsgdTu6WM7NU4I0jkVARXteCU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=l4Y2sqLnyzXR/XvAoq2mHPf2OB/BmVMC9zbxiRw37VFkQOn8KWNSfRi4p6LSf/pOy
	 T2KJmlwKvI9wGd8459ss3gaqG2kk04Xr9BstsmY1ECfbCnucWKdReWHgf9djZ8/dh3
	 2i7T6g3UwD0MV+hxKz8/CRfjm6cCa7MKuzW6oP3d1MgSyFYde4rPUfhjQLgJIe68en
	 d+unHmp9yRT1K7JzEDbB2/RUPCWZWs3th2DOmThQtXBPk2XNiuUY5mhdq6Kf25mAZB
	 oUph5YIsADi86gXPYebNLlnBtV18sog7dUT1A2gb+9eIPnMXIVJO4n2WWbrIFqBAnE
	 yxlvn8ZCHy22g==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 1AE772E00DF; Wed, 28 Jan 2026 13:05:16 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Li Chen <me@linux.beauty>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [RFC 0/5] ext4: mark more ops fast-commit ineligible
Date: Wed, 28 Jan 2026 13:05:05 -0500
Message-ID: <176962347636.1138505.14797940787687720541.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251211115146.897420-1-me@linux.beauty>
References: <20251211115146.897420-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 11 Dec 2025 19:51:37 +0800, Li Chen wrote:
> ext4 fast commit only logs operations with replay support. This series
> marks a few more operations as fast-commit ineligible and accounts
> them via fc_info so behaviour under fast commit is easier to reason
> about.
> 
> Testing was done in a QEMU guest on loopback ext4 filesystems created
> with -O fast_commit[/,verity] by exercising each operation and checking
> /proc/fs/ext4/*/fc_info for the corresponding ineligible reason and
> ineligible commit counters. Detailed steps are in each commit's message.
> 
> [...]

Applied, thanks!

[1/5] ext4: mark inode format migration fast-commit ineligible
      commit: 87e79fa122bc9a6576f1690ee264fcbd77d3ab58
[2/5] ext4: mark fs-verity enable fast-commit ineligible
      commit: 16d43b9748c655b36a675cc55789f40fd827e9b1
[3/5] ext4: mark move extents fast-commit ineligible
      commit: 690558921d9f9388c6bc83610451d8cb393e4d88
[4/5] ext4: mark group add fast-commit ineligible
      commit: 89b4336fd5ec78f51f9d3a1d100f3ffa3228e604
[5/5] ext4: mark group extend fast-commit ineligible
      commit: 1f8dd813a1c771b13c303f73d876164bc9b327cc

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
