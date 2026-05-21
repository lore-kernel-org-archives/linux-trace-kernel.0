Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881D233EB1B;
	Thu, 21 May 2026 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375440; cv=none; b=KKVKu3wQqRscjV1dG/hQwYSQlgYfU03HEKNsh1GSLiEo5eclH/6Lle4FohGZnk27oYXEUISwJDZBAgj2UjvVrBX0ZOV2Mb/FGVsX233ZpsH7AcUkKZvvpP6HvgYs6qfIWmGllXPiHAV08bgxPNhfVyvi1V2dlc2/ETZpxvNxViI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375440; c=relaxed/simple;
	bh=nz4kmbOBmGr+SUOh5mR5Fsn6yNAK7PTuqFMNVpomyUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDam2m+r9aFq4E3lh6SUy/RaAnzBhNwv01ZofYTndgHAGE0sAHEfOUnWgrejFhuQY7ws7ySgWq1ZworhDauEKVUatPhrkQImz2qF96mVZevrb4hGkFcGfrJZ17ZqPOaeUiVFay4Dlhw+fXXmuMgFq7Ug91SJ3l4JPJoV7RXDrck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CepTCFLD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CepTCFLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD111F000E9;
	Thu, 21 May 2026 14:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375439;
	bh=Epyp8E4KL7jLxGFFv+Ta11ruWAThfrUzN85SlyNXVzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CepTCFLDvIn7Q/jz5ruokdIsDLPM04SrvFq6lFAYPaZPKkUYUlYYmNc2qFGHxlttK
	 9ZptM8bLYOOse1y2tXBPfevGfazPgp6gts2cb7qxvzYd3S4ELUT+F+wvSIEcSjmINz
	 fheqzxFuxAZRzlR43PQGJY4MMin925FpDbYw/8eN3Ha0BLVEcQp5IVdQaoQ51i1S6X
	 9DkRQqryfejtp7KlCOVq/PnXuzJyk/SdjU+Q55oNTN55C056uLzlV2aQkKUVHYF2zJ
	 VfC+GJiYj/wYXXnsBxVVCbbqGh6ANQZWrfD2UY4I3jbVS8r8aZP8K/6tj6WBZuLi7q
	 wzv3hlaUpglng==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] tracing: Record and show boot ID in last_boot_info
Date: Thu, 21 May 2026 23:57:16 +0900
Message-ID:  <177937543666.2596845.9748178606108139386.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
In-Reply-To:  <177937541909.2596845.17729857441826694760.stgit@mhiramat.tok.corp.google.com>
References:  <177937541909.2596845.17729857441826694760.stgit@mhiramat.tok.corp.google.com>
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

Record the boot ID (random UUID for each boot) when tracing on the
persistent ring buffer and show it in the last_boot_info file.
User can use this boot ID when cross-referencing it with other logs.

For example:

  # cat /proc/sys/kernel/random/boot_id
 df152e7a-c0a7-4d32-9f0b-7f5c39fb7b68

 (enable tracing on persistent instance and reboot)

  # cat /sys/kernel/tracing/instances/ptracingtest/last_boot_info
 # boot_id: df152e7a-c0a7-4d32-9f0b-7f5c39fb7b68
 ffffffff81000000	[kernel]

 Thus, if user saves the other logs with this boot_id,
 user can easily find the appropriate logs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6eb4d3097a4d..c56694bb5e0c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -34,10 +34,12 @@
 #include <linux/percpu.h>
 #include <linux/splice.h>
 #include <linux/kdebug.h>
+#include <linux/random.h>
 #include <linux/string.h>
 #include <linux/mount.h>
 #include <linux/rwsem.h>
 #include <linux/slab.h>
+#include <linux/uuid.h>
 #include <linux/ctype.h>
 #include <linux/init.h>
 #include <linux/panic_notifier.h>
@@ -4804,6 +4806,7 @@ struct trace_mod_entry {
 struct trace_scratch {
 	unsigned int		clock_id;
 	unsigned long		text_addr;
+	u8			boot_id[UUID_SIZE];
 	unsigned long		nr_entries;
 	struct trace_mod_entry	entries[];
 };
@@ -4921,6 +4924,7 @@ static void update_last_data(struct trace_array *tr)
 	/* Reset the module list and reload them */
 	if (tr->scratch) {
 		struct trace_scratch *tscratch = tr->scratch;
+		const u8 *boot_id = get_boot_id();
 
 		tscratch->clock_id = tr->clock_id;
 		memset(tscratch->entries, 0,
@@ -4929,6 +4933,11 @@ static void update_last_data(struct trace_array *tr)
 
 		guard(mutex)(&scratch_mutex);
 		module_for_each_mod(save_mod, tr);
+		/* Also, update boot ID if exists */
+		if (boot_id)
+			memcpy(tscratch->boot_id, boot_id, sizeof(tscratch->boot_id));
+		else
+			memset(tscratch->boot_id, 0, sizeof(tscratch->boot_id));
 	}
 
 	/*
@@ -5822,9 +5831,10 @@ static void show_last_boot_header(struct seq_file *m, struct trace_array *tr)
 	 * Otherwise it shows the KASLR address from the previous boot which
 	 * should not be the same as the current boot.
 	 */
-	if (tscratch && (tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
+	if (tscratch && (tr->flags & TRACE_ARRAY_FL_LAST_BOOT)) {
+		seq_printf(m, "# boot_id: %pUb\n", tscratch->boot_id);
 		seq_printf(m, "%lx\t[kernel]\n", tscratch->text_addr);
-	else
+	} else
 		seq_puts(m, "# Current\n");
 }
 

