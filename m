Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53BF17C21D;
	Tue, 11 Jun 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112632; cv=none; b=WW+0nMstfzQyMkJjEfo2XofNjAqSW2FZyUTAPl6W2bZN5VH0oRk2hMAPpMr3qICqJEDoyfTviuKE3GCJOzN3ERPsi1z2DkkZ0eS9Lg9qtz/NqLBIRJ2nXdsXulDi+7OjTTzhKF0xgr1+/ogwdzkeuo216SrEZQhxOf6hJChP0HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112632; c=relaxed/simple;
	bh=NXb3HaeTQ1KSXRxrj4kItzQB2kuaUrDr2uem270lec0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UU3JQfS9G2KZeK/M9aeZubNwOaoSIlg4XCwmp39lyuiUKjKlNcKBO+FIBSWrIy6NzbN+/hhsyd9gEdr0uehMU81/ZOfzuf1hY6VFxayZNe1+QPciK0yq271v5Eq01wzgPzWtv5/mnIHAhlps6CKHHcqvZ48FwTBovz/v7163YmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEDnJwrG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEDnJwrG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97F6C2BD10;
	Tue, 11 Jun 2024 13:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718112632;
	bh=NXb3HaeTQ1KSXRxrj4kItzQB2kuaUrDr2uem270lec0=;
	h=From:To:Cc:Subject:Date:From;
	b=OEDnJwrGBNr6hbsmpAoAXAWUpZGjjYpFBrc+50yKl1jX36RxXdA2uQd8ipk6tz6uk
	 dOLHFZAPEuG7Fdj+Hh3KDkI4pjU5jAy7IKrg/ue1nc8F8TndBYN0em2wHV6wjJvZ5C
	 ux9ooe6z91cxQEF+JI8r3k8dUAPW0RTidzPav6+jRnys51BwsGXZ6mpFHXBwS+6H8C
	 tpnQ66CdOkAEmAoeeEbMkfohjlloYdw1kWUiL/hsSgb0L8fvNuVPqeRzTz1DRx3rlh
	 qJ+qow+wUht6T6mfMoZc9cFXxVoGOgih7bnCQHiGwBeI5inaWZeUUDfT+akgo9vCOR
	 EbGUXoJ+5Fqzg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v3 0/3] tracing: Fix some selftest issues
Date: Tue, 11 Jun 2024 22:30:28 +0900
Message-Id: <171811262833.85078.12421348187962271050.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is v3 of a series of some fixes/cleanups for the test modules and
boot time selftest of kprobe events. The previous version is here;

https://lore.kernel.org/all/171805478534.52471.6269290579314514778.stgit@devnote2/

In this version, I updated the 2nd patch to integrate WARN_ON_ONCE() and
pr_warn() instead of removing WARN_ONCE() because this warning messages
are needed to ktest to handle errors.

Thank you,

---

Masami Hiramatsu (Google) (3):
      tracing: Build event generation tests only as modules
      tracing/kprobe: Integrate test warnings into WARN_ONCE
      tracing/kprobe: Remove cleanup code unrelated to selftest


 kernel/trace/Kconfig        |    4 ++-
 kernel/trace/trace_kprobe.c |   54 ++++++++++++++-----------------------------
 2 files changed, 19 insertions(+), 39 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
