Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF56E4DAF85;
	Fri,  2 Oct 2026 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955597; cv=none; b=mchv/vH0F4kS5vGhy7+H/l6BPBpN1w24OPEIrzHjl2tGRIHn+5rBViYxfbs07YO9dRHykG9nXINfih0k2go+vZXqBvOcXd3MEBUSshXxMj5PawKModbFaToh9sKAZ1jvi+BIzWmH6tHS0bra9z7TCz16rHLGrLIFAkEpEUh9HrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955597; c=relaxed/simple;
	bh=HNpc0I6euq0rv1q+gLOiV8btlXybsvf2RjUOEnsIgp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BiARm/x3lQ8iMOOW3WI4Gu8UixkGDUEHHh8YQd5ClZWaUBoq4JkRoUu+IQ5tzfKXbBgp4wFlqc25oBeF81A1iE7fNscp/9tw/G2GMKIPAlvd8xRoVsVXhcpr9XDwXr0C2U9yhmiNCveJ3Wlj6e6fe3pjU84c2v7sJTewNOo+oM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kKXLefl8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kKXLefl8"
Received: from jeffbarnes-ThinkPad-P14s-Gen-2i.corp.microsoft.com (unknown [52.167.115.14])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2FBE920B7166;
	Fri,  2 Oct 2026 08:38:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2FBE920B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790955532;
	bh=VCiGsdCCjx/n7No25E0tyjU84+JUkR28ts3SmgGX6cg=;
	h=From:To:Cc:Subject:Date:From;
	b=kKXLefl80t6Sn0yUpp4EE1+m9cbtMp4HA1XzZFUoMC8qVL3irdp3x3BqO/1CZZ74h
	 fxcX+9W3e53MA11n0SNzQ5ClnvG6l1piVIglhvN0rmDs70DYlxCxCTGD4aPx4eqwxq
	 8h4eWT/ZSmnM2GaND3+7EqsZY7oTyV06FD3Z1piQ=
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] tracing/user_events: Share state between existing threads
Date: Fri,  2 Oct 2026 11:39:32 -0400
Message-ID: <20261002153934.798176-1-jeffbarnes@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Threads sharing an mm_struct can create separate user_event_mm instances
when they were created before either thread first uses user_events.  Each
instance then has its own enabler list, allowing two threads in the same
address space to register different events using the same enable address
and bit.

The first patch adds a deterministic regression test that creates both
threads before registration and verifies that the second registration is
rejected with EADDRINUSE.

The second patch makes current_user_event_mm() find and attach to an
existing user_event_mm for the current mm_struct, and synchronizes
attachment with removal of the last task.

Without the fix, the new selftest fails because the duplicate registration
succeeds.  With the fix, the registration is rejected with EADDRINUSE and
all seven user_events ABI tests pass.

---
2.43.0
