Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4502F1FF4;
	Thu, 21 May 2026 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375425; cv=none; b=VwCXJZ3w+yODxjGJAfWP0n/RkLxio0ldoq8kzVc4k+9dSVJZsKpYiy5LH0TK+Ht2dAubtNsBXFdZHuJBDDrKV+K4EU+gihwjFc+xTgVA9dMdGJM7oJ/JhruK/zor05ob3P4W4ObNPXxRlswRwpzNh9vetuuh3xNyISoj78JN5Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375425; c=relaxed/simple;
	bh=WjUjwLMOalgoEHLwGqBDytr0HoG8olcQw9qa50jOi/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DMJq8qduPEiKVxKsC1GttcUoesfffZqj+EiDNaVKWG4muNiKv+KX+uawbdtWCysimuasjRO4ZHoyx2TFJZF1i24XHTqEx6e7x8zSN18jSFyMqz3HPHMhrFDRDG3o+LnoXOzinO/Z/ZqorQ3XNrk++BZRvUEkvSQ9wbnBCIL7ZdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o06aFPdo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o06aFPdo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61EC1F000E9;
	Thu, 21 May 2026 14:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375423;
	bh=ubGQwjkSeHJC9kTKcjGioyI9bzXE4kQuRzPyjZeZJ9k=;
	h=From:To:Cc:Subject:Date;
	b=o06aFPdoj7kQfcjZO9/q3t35M2v1WDwCJu2q55Mt3Z/XnZNI8ZUtbePOlshK9L2V8
	 DpsWFpGvmkHWmrpzX+1bovK4OisnJeAuFdV+S0bE4ZCqRXZQ4iSRQx2pcezzxvljYF
	 P6nRbYZVewdlPP5NsYq34uxeqgQVejjeIrMsne4UD3yEl5iI5PTEDFMG9YdHctORLq
	 js77IR3q+4hBBhQAUPoY8ytvA6lZr6GLkH2nZ+wFj4Xn9bHchWsoOWjFaYE3Xoau6c
	 Gl3jkPQQDP6jTmaCqzHDe3Ta2Cwdufc8Osw4MxKPPwes+QRv2lkJ67w/SlLg/ad0To
	 KC8VKap7rGa3A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] random: tracing: Expose last boot ID on persistent instance
Date: Thu, 21 May 2026 23:56:59 +0900
Message-ID:  <177937541909.2596845.17729857441826694760.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
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

Here is an RFC series to expose the boot ID (random UUID for each
boot) in the last_boot_info of the persistent ring buffer instance.

The persistent ring buffer can hold trace data beyond reboot/crashes.
This means the recorded data does not always come from the last boot.
Currently we just assume that the data comes from the last boot.

On the other hand, the kernel provides a random generated UUID for
each boot time, called "boot ID". If you record the logs with the
boot ID, it is easy to do cross-referencing it with other logs.

Similarly, recording the Boot ID for persistent ring buffer
instances would make it easier to determine which boot the read
data came from.

For example:

 # cat /proc/sys/kernel/random/boot_id
 df152e7a-c0a7-4d32-9f0b-7f5c39fb7b68

(enable tracing on persistent instance and reboot)

 # cat /sys/kernel/tracing/instances/ptracingtest/last_boot_info
# boot_id: df152e7a-c0a7-4d32-9f0b-7f5c39fb7b68
ffffffff81000000       [kernel]


Thank you,

---

Masami Hiramatsu (Google) (2):
      random: Expose boot ID to other subsystems
      tracing: Record and show boot ID in last_boot_info


 drivers/char/random.c  |   27 +++++++++++++++++++++------
 include/linux/random.h |    9 +++++++++
 kernel/trace/trace.c   |   14 ++++++++++++--
 3 files changed, 42 insertions(+), 8 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
