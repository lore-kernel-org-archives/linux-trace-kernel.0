Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ED8146D76;
	Fri, 29 Nov 2024 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732898873; cv=none; b=EONIU05T0GfABKaE5ZABMGZifdkWPXh1mFUeiGhpt8WYSwEGkZfPO4ST5WSbBwDkWSrfKSw55xv4fu+/V3wXKyGiGw6cCrqYRgZ8DYUBDNblAOX4T093GxaVp83XvELm0BZ9H9beKmoV2iLmR75mjwlTfIs55RnpX5pLeBHapeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732898873; c=relaxed/simple;
	bh=OUbH2yDyiXtr4xG2OF1k8+O5wk66wGWYCe1qQImrZI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JP4tnRrSi4SbGJPd4PMZDau4k6/1T+v+ug/jmKUsRTT4LuBqOanO7V7FO1MmbtmrA9kDRt9zbxhBnVRXFLMldJklS+nxFbmjRBt77cOnrSq/0PS2vuK0YdH5FkwIFJVmOT9vLg4aWMchnEbqMVEwi4GYF6v4UFX7VjaMBqchWtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rodo0E3u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rodo0E3u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77342C4CECF;
	Fri, 29 Nov 2024 16:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732898873;
	bh=OUbH2yDyiXtr4xG2OF1k8+O5wk66wGWYCe1qQImrZI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rodo0E3ucGOXZtm+E9Nh9EYunpwfCGafZ568xD4A5Z+93CVl46qgPTfdXBLLO9oIU
	 CBuVMiTD/9gIMq8UX3koBHxmXggg3GcOJgFA3BiSX1JZT74C8E3o1x3Z1Nld+77LsU
	 jeZm9znsWXg9Kvap+JKtlueu0FmRafVoFilnQnSRd6NgU9oSBX8s2YRTfX2j/f/tKy
	 pAggNK5t/Vk2aVUNTGzpOsxA+GNz2hyzJrlIKWJj6vh1lBo+nkgY2+F+rxsCkeBQaR
	 u6Xe+Znbs3SWJ1O0nvRHw+M72Bc04wl/t1hZi9hOjHtsuP6L1MCZ4uTlWWGSMzOQEl
	 u7Ux8ZX6255Wg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Naveen N Rao <naveen@kernel.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] tracing/eprobe: Fix to release eprobe when failed to add dyn_event
Date: Sat, 30 Nov 2024 01:47:47 +0900
Message-ID: <173289886698.73724.1959899350183686006.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173289885627.73724.13632317993038475335.stgit@devnote2>
References: <173289885627.73724.13632317993038475335.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fix eprobe event to unregister event call and release eprobe when it fails
to add dynamic event correctly.

Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_eprobe.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index ebda68ee9abf..be8be0c1aaf0 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -963,6 +963,11 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 		goto error;
 	}
 	ret = dyn_event_add(&ep->devent, &ep->tp.event->call);
+	if (ret < 0) {
+		trace_probe_unregister_event_call(&ep->tp);
+		mutex_unlock(&event_mutex);
+		goto error;
+	}
 	mutex_unlock(&event_mutex);
 	return ret;
 parse_error:

