Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3704727D77B;
	Wed, 20 Aug 2025 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755716797; cv=none; b=CQeULG1CoasK3BZw2A3zjks1LR/fxQ0WCa6cG1NRB7rzzq5E3GeYnTbjHQqVNVo/WP/D8/TZMNqlwT6laFlt3yVVsa+1U+/rru1+HxEFSwQl0czTJ4kXk0YMdnmsAcZc0Fx0HK6Kr34W7OtY/zCcZvlwX5I6aGtpA64N7J1qu2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755716797; c=relaxed/simple;
	bh=reji3fEkI4pxXPGjg4kAjTYYm4TeYGOSYYg7sd9dMrQ=;
	h=Message-ID:Date:From:To:Cc:Subject; b=ul6Mt17TAV+Y7DqUEfUwvCzz24k+r1eJqJYOOprlfkKtjVOzwn7CfnWDSsFXedfyYOGQIbGqS6XPNzWQaKocsmh/oHPW0sSL7rjQnkWtKCxiAu00A+Y16Nh2NAsx2cqz2EXsSEw/j+cElAVtQMYilqVM/NhqFvTvfGrbtmSPm4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cp5qMR/l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cp5qMR/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F4DC4CEE7;
	Wed, 20 Aug 2025 19:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755716796;
	bh=reji3fEkI4pxXPGjg4kAjTYYm4TeYGOSYYg7sd9dMrQ=;
	h=Date:From:To:Cc:Subject:From;
	b=Cp5qMR/ljFXqZxUZsX30812oSPesXCIfeMFJHkdlw4kxhxXMANVHyYg4/LzJUEMXB
	 oF7GP5c0GERntpGmy7fgkcWNOMIJY7GFLy//gyTO05UD4BdXDwLa1J/VpA74ApwbR1
	 /NNhqMceP1gTA+MnGoZBfHKyms/guH2Y2bWs8oc94708F4U7zz/Hh6dZiDomlNAep8
	 OLl1smFOE/elxbZm0JRrlkDvcpHbhSqnNAdTgm6DS/L2m9yiUmSjiYox/3s7I0Cwlx
	 bpaX4oYoTsMCPgAK/d4TC9W+lKw+5gMyTvg4DdPwEfe6cDi8Rk7sGtrRIODWKQMWsK
	 VoCd/EUOs9Nhg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uoo8t-00000000tEP-2iLp;
	Wed, 20 Aug 2025 15:06:39 -0400
Message-ID: <20250820190546.172023727@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 20 Aug 2025 15:05:46 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 0/2] x86: Enable the deferred unwinding infrastructure
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


This enables deferred unwinding for x86.


Josh Poimboeuf (1):
      unwind_user/x86: Enable frame pointer unwinding on x86

Steven Rostedt (1):
      unwind deferred/x86: Do not defer stack tracing for compat tasks

----
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/unwind_user.h | 22 ++++++++++++++++++++++
 include/linux/unwind_deferred.h    |  5 +++++
 kernel/unwind/deferred.c           |  3 +++
 4 files changed, 31 insertions(+)
 create mode 100644 arch/x86/include/asm/unwind_user.h
