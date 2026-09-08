Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07BFDF59;
	Tue,  8 Sep 2026 05:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788844773; cv=none; b=Mo8xH+5oASiKg0Tt4iadVtEKrbljjq1OC7qO+7f3inGCcNrq+I1iawLu1vFSyadVvQx6aFdTWrEKJfPFk1yA8H+oWavjQQO4VdTrw+3q/Uhu+Tpj2HPwmfT2ONdw5dh5Fg7zsgr/D/fMQ1CZekpNvvs0WfE4zrSRJ5TUgEiQo/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788844773; c=relaxed/simple;
	bh=10fUHKpmSTJ+7R5x0KbZuyTXiA3ie8KsbJgtDEqUc78=;
	h=From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=YbpNqKBmLw7giOYiHVtsyvkoedB1yb0z0ENGPjU1koH/d8/9BducUxh7gUhCMWb/GbmkfEarmzI1+FMVCcOstOhWbLHY4D8iCEykytF9mICg+ptBZch7Dc2oen2tdqZ5yD8Bk4+OKmtCGyUZL2ZdeYSLFKs6YhcpOKuY0Lk0oc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BGFN+osx; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BGFN+osx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:MIME-Version:Content-Type:Date:
	Message-ID; bh=10fUHKpmSTJ+7R5x0KbZuyTXiA3ie8KsbJgtDEqUc78=; b=B
	GFN+osx/DyscS3zmrs/knSYtHEJPBP4Mey16RFpLdwy+7xfcnAA26wwXEGSVd545
	LV1TWDGRFV3RvO8znHI6U1G3X1dGanc4ByeRVW+u4SexLDrK4S/mKdLCWvxytep2
	pOTvLQ1aItGpJsddomJ7cDhptUbjvvUv+UpSidunM4=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBXIM6mmp9qk6R1BQ--.60461S2;
	Tue, 08 Sep 2026 13:18:31 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Shuah Khan <shuah@kernel.org>,
 linux-trace-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tracing: Export live module tracepoint strings in
 printk_formats
In-Reply-To: <178647423521.280401.10184675433127100074@163.com>
References: <20260428083920.4a64eaf6@gandalf.local.home>
 <178647423521.280401.10184675433127100074@163.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Sep 2026 05:18:23 +0000
Message-ID: <5ba26e8ce9dd4d51ab4ff7c75f14b139@163.com>
X-CM-TRANSID:_____wBXIM6mmp9qk6R1BQ--.60461S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtryxGFW3Cr43KrW3WFWruFg_yoWfuFX_ur
	yqqwnFgw48uanFyrs8KFW5Xa47Cw47u34UA3y8uwn3t348ArsrGF4kKr9rXw1xGa4F9F9I
	ka1kJa4xJr1avjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbX18PUUUUU==
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbC6AdSi2qfmqeoeAAA3u

Hi Steven,

Gentle ping on this v3.

While rechecking the selftest, I found that the unload checks can miss a
failure: if the first test string remains in printk_formats but the
second is gone, the test still passes. The first negated grep returns
nonzero, but set -e does not terminate the script for a negated command.
I reproduced this with a fixture containing only the first string.

I would add explicit failure handling (|| exit_fail) to both checks.
Would you prefer a v4 with this correction?

I can also make the final rmmod failure fatal and add a comment explaining
that trace_bprintk_fmt_cnt counts permanently retained, unique formats
and therefore is not decremented on module unload.

The current test checks the exported mappings, but does not exercise the
new membership lookup through a TRACE_EVENT and the tp_printk path. I can
extend coverage there as well if you would like it included in v4.

Thanks,
Cao Ruichuang

