Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BAB30BF6F
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Jun 2026 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584509; cv=none; b=eZIqkOmKKebTjzTIaKc2sqF8Mnh4WAurgYsUeDOKFanxbQNJ4yLWDDOsSQQF7P+vx/K7BRio1BJMwK31rr0D40vLHGSSP6sqMXdiYKJQStEuorJEyPr81Bj9e1YQYCY7s2Hb/ckkrOJBAg/GH/fszRRavWhgm79eo2IsiXjDdzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584509; c=relaxed/simple;
	bh=5Fu4qY1GmiwIURGlUvfJKFwG81u/TcJ+SCFMpL1goYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJBH/+MNxWzU9kCts7Os/VMH0RauZ2flvpBqgCCxbhDp3/Esr3qH/RIavyA2gJsB7c2orHaG0xn7ozdz4xRVW+cSc7/xdhvzpN/N0LTCFGFyrI7vMvJaV1QqUyOu80iEXi7J+Q7u4jT+0Ri7yybeCD/6Y8h0nhVzPXMPtW4wbyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ms0/nnUB; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ms0/nnUB"
Received: from trampoline.thunk.org (pool-173-48-113-247.bstnma.fios.verizon.net [173.48.113.247])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 654Ejvko012396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jun 2026 10:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1780584360; bh=iQLaUZ6KfLqeynbU8qNojf2wT+pmng1jb1yjgIcTcQI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ms0/nnUB+doR92NlAb7eBy1AnnDptOyzqWGZjrBf4uQFDErWyLQMMj1EC/0YOkN+V
	 hH3/B6OstW0sxhQymdg4zz5X70ezjVHjLQAE/T8pqx9YRSFSG2Kp3M65+s46IAoxtz
	 5CqIBvp4NHCBLFs8C+xRAgsPJ+qYBq+z9etO06QbTSSUgE+CabInghCXEZf96JiSCD
	 yK7lsXjkz0EW19AiGqBQdkcOJmHKAGiFs2jQvVUGnssUqsaHWiV7nCfRbHpM47ZaUm
	 ROmd3376plOXveaQBIr1jxD2zWnbOYhHj6/TfWXdAVKH0wzcLpdryd6uTLsvdzhrk1
	 6WdJlsF0Q4plA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 6FB522E00D3; Thu, 04 Jun 2026 10:45:57 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zhang Yi <yi.zhang@huaweicloud.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Li Chen <me@linux.beauty>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-ext4@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v8 0/7] ext4: fast commit: snapshot inode state for FC log
Date: Thu,  4 Jun 2026 10:45:51 -0400
Message-ID: <178058434004.388727.5524896340442581601.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515091829.194810-1-me@linux.beauty>
References: <20260515091829.194810-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 15 May 2026 17:18:20 +0800, Li Chen wrote:
> (This RFC v8 series is rebased onto linux-next master as of 2026-05-09,
> commit e98d21c170b0 ("Add linux-next specific files for 20260508"), and
> depends on patch "ext4: fix fast commit wait/wake bit mapping on
> 64-bit" [0]).
> 
> Zhang Yi in RFC v3 review pointed out that postponing lockdep assertions only
> masks the issue, and that sleeping in ext4_fc_track_inode() while holding
> i_data_sem can form a real ABBA deadlock if the fast commit writer also needs
> i_data_sem while the inode is in FC_COMMITTING.
> 
> [...]

Applied, thanks!

[1/7] ext4: fast commit: snapshot inode state before writing log
      commit: e9c6e0b8e096255feb71ec996c77bdfbe9c36e91
[2/7] ext4: lockdep: handle i_data_sem subclassing for special inodes
      commit: 7f473f971382d73a58e386afa7efdaac294b89f0
[3/7] ext4: fast commit: avoid waiting for FC_COMMITTING
      commit: b3060e96533dc3157fc6d3d45dc19927c566977b
[4/7] ext4: fast commit: avoid self-deadlock in inode snapshotting
      commit: 2b9b216628fd9352f9c791701c8990d05736aa90
[5/7] ext4: fast commit: avoid i_data_sem by dropping ext4_map_blocks() in snapshots
      commit: 22d887e06a57261df58404c8dce50c4ef37549ed
[6/7] ext4: fast commit: add lock_updates tracepoint
      commit: d2f6e83bbbef31169ea363af4277f5c09c914eda
[7/7] ext4: fast commit: export snapshot stats in fc_info
      commit: 56bb0b64f4b198bad5ce674509c10793d471148f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
