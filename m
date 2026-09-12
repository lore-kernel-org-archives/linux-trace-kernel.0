Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC7F362120
	for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789206450; cv=none; b=pOYlzwysC0tppbl9Kfr6qRwuSBDaILoVx7ouLS1Gy0rOK/MnjstHu2OpuRAd/AITcs6ZpNiprmy75Q2R3KC2u/PtfTV039UM+qx1LMfFnELjlZD0WOmk+ZiXMGjuKkG03z0OPNhkP+0clzBF3wF7vsDqf7+XHUeiYQP6qOxBhOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789206450; c=relaxed/simple;
	bh=itGMohRPUknE9RWN6vUhYvo7ZgGUPk6FJsKC8weTApM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cXRsJNOKIthTYWR6ak1zzGOMj2xkxOf/mlKMxbKzMKa+SUuiQQ9jp6ozEQPGbm4THgRWtFcKrV0Q3q9CL+H9SVtt2T7/pvRjoEI3KZbw/jUV1dfEj7ng/vzn0+W37Jcpbh3NknL+9eU6iBze3iuZ49S6A9y6dDZE7RDJU5vcsOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsWhUyiz; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsWhUyiz"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd66bb5so335708a91.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 02:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789206449; x=1789811249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V6jujE+HIHSzbTLZbvccwWnDfwDKROV6ykZ70hevecQ=;
        b=MsWhUyizNvGMBElOMohKz7/cKM9kihrg49Hcqe+m7qqA+tsGWyyJS9Ko0tEp4fc6iN
         Jl7x1s/fwgLBWBuV4WRyOkRVUybCSfmeK45zqWltOhzfw8cYvghD9NhkJ4h6EjIai+3A
         dAJmM9oM/DCQeVr7uN2pLA9u89k1ned09uphMTsKAsgDetozQD8yJTjhuA1jq5gJ2jdU
         y0LRJMRWpKNo7O2dbkoPSA21pqbDm9HFhJD0dLzCa3dlIaJQnqsYXnLjAkDLagwHXqTm
         DqSS309b2LtK/+94HAOXUefm4lmxqe2bElksIKJjaIPpeLbydPVzRlQyx4XlrUIDHjWW
         qmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789206449; x=1789811249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V6jujE+HIHSzbTLZbvccwWnDfwDKROV6ykZ70hevecQ=;
        b=qeokxTco+BLRj9r5XIH6VOWPEsoZO15LFda6C9mu3n9iMNpjQtUhPW85Z/fWu6Eaun
         Sr6hE+j67NGCHj6546bazQRjpiPeQEmXj5g6ODrFf8i+BTUot/CRLTVYAsXYmhm4xNgI
         wpBEHyRXyase4ABIhaX0u6bGHiO3ynzrqSEGfYJp9Taz3UAf83frHlM3bbF9npCxXn/J
         OsV4zy4n5c0PLHd6v0Ha0GKv9l0nOeGrmQgynMOtQReA11t312+zW9StHZ3KPcqllTqD
         ou84eY32HrhDnD3VgH3Y961xIgRdMaMVzZaV5akPBprseLp3OJRKEUS+c0S3QHrmzzG1
         9Hlg==
X-Forwarded-Encrypted: i=1; AKwUvBzh2ewrVs+EcKEmnxui9FbSrlkOLXQA1k8m57l9YcGU1XUhx5fq+xS1byGatphglUl7uHHstYmumbiz7zlgUUfDnjM=@vger.kernel.org
X-Gm-Message-State: AFuF++kHP5F7qgKosxsaFM63tbU8QokGXxvregcS3UgnNF/RphBBnNZW
	lRWNmxhAlfpoS95E8w1Gsb3m5TsF5nltdy4unI9ysWytWylDCbtan3Y=
X-Gm-Gg: AYBFou1qm+zYSsetNjD6XX3hrhWhgyB4CBUJzOsRD1zdb3fI59FHHRvhvSZOJKgaNcn
	yEGhyT4e1nU0xyz17EnGHMmwklJZ7A0UwStF3F/fAnWQwFs8J50UAupW2h3yU1F+zhG1/vMTCoo
	jUqhnAWUUGt28zuEuaWNJgesn3AFCotCbNNbHID+BJS2me3xLw5J5IxRMPqEymLLLpmGFqGdxt1
	xEWfBC5da0fvq/XW0RqUDHW2nn4zunYSp1PExfmKYd5BE6OTfaoh3uVMfhsfC4BV8ZgTHH3ytS8
	wzhl5XKvfq7T7VRCIPBHeswMcXD83qdVOZ6RktqfFbh7KkpprfkBxoc+KuqXmYl6AVV0dzR7A7g
	59ia8qnRGTznawhHqtZhFUcJ8MXxy4Mo77ih3RrRaCqqdbrn1/KDO7b5ofaeraU0BM8aI/7vxSH
	CPZC8o096LI033q1L0mACtGR4SeQkTU+w8VujuXOq2uATZdn8lSutipWrV0gAvh2uPaGe8GsaRg
	7ti+mHOPwndFfa/BAPwQopr4/u0XzvFJ3e0
X-Received: by 2002:a17:90b:5904:b0:393:288:29e3 with SMTP id 98e67ed59e1d1-39dbc0cdea9mr3664901a91.10.1789206448741;
        Sat, 12 Sep 2026 02:47:28 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994d8af1sm9903297a91.11.2026.09.12.02.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 02:47:28 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH] tracing: Fix NULL dereference when copying keys for a field variable
Date: Sat, 12 Sep 2026 18:47:22 +0900
Message-ID: <20260912094722.3271147-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

create_field_var_hist() builds a hist trigger on the onmatch() event by
copying the key list of the compatible histogram found there, reading
each name from key_field->field->name. That pointer is NULL when the key
is not an event field: parse_field() leaves it NULL for common_cpu,
common_comm, common_timestamp, common_stacktrace and hitcount.
compatible_keys() compares only the type, size and signedness of each
key, so two common_cpu keys match and the loop faults.

The generated trigger is a real histogram whose element the variable is
later read out of, so it has to bucket the same way as the one it
mirrors. Render the keys with expr_field_str(), which carries .log2 and
.usecs, modifiers that change a key's value. Two things it did not carry
are added here. get_hist_field_flags() reports .stacktrace for the
common_stacktrace pseudo-field too, which parse_field() takes only on a
real field, so gate it on having one. And it reports a bare "buckets"
with the size held separately in hist_field->buckets, so append that the
way hist_field_print() does. expr_field_str() also renders expression
operands, so an expression over a bucketed field now prints the size
too, matching what hist_field_print() already shows for the key.

  # echo 'hist:keys=common_cpu:ts0=common_timestamp.usecs' > \
      events/sched/sched_waking/trigger
  # echo 'my_synth u64 lat; int prio' > synthetic_events
  # echo 'hist:keys=common_cpu:wakeup_lat=common_timestamp.usecs-$ts0:\
      onmatch(sched.sched_waking).my_synth($wakeup_lat,prio)' > \
      events/sched/sched_switch/trigger

  Oops: general protection fault, probably for non-canonical address
  0xdffffc0000000002
  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:action_create+0x1cb4/0x2e50
  Call Trace:
   event_hist_trigger_parse+0x3e47/0x69e0
   trigger_process_regex+0x1a6/0x250
   event_trigger_write+0xce/0x160
   vfs_write+0x1cf/0xde0
   ksys_write+0xfd/0x200
   do_syscall_64+0xda/0x4b0

Cc: stable@vger.kernel.org
Fixes: 02205a6752f2 ("tracing: Add support for 'field variables'")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5 [checkpatch]
---
QEMU, x86_64, CONFIG_KASAN=y, base 7.3.0-rc2-00020-g815e07c8fe88.

Eleven key kinds, one harness, both arms. Unpatched, common_cpu, common_comm,
common_timestamp, common_timestamp.usecs, common_stacktrace, hitcount and a
constant key each oops; pid, pid.log2, pid.buckets=10 and pid.buckets=64
survive and mirror as keys=pid. Patched, every one of the eleven generates a
histogram keyed exactly as the one it mirrors.

ftracetest test.d/trigger/: 37 passed, 5 failed, 0 unresolved, per-test
verdicts identical between the arms, "test field variable support" passing.
All five failures reproduce on the unpatched base.
 kernel/trace/trace_events_hist.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8af97fd4ee2d..257f5012a4fa 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1725,7 +1725,7 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 		flags_str = "percent";
 	else if (hist_field->flags & HIST_FIELD_FL_GRAPH)
 		flags_str = "graph";
-	else if (hist_field->flags & HIST_FIELD_FL_STACKTRACE)
+	else if (hist_field->flags & HIST_FIELD_FL_STACKTRACE && hist_field->field)
 		flags_str = "stacktrace";
 
 	return flags_str;
@@ -1754,6 +1754,9 @@ static bool expr_field_str(struct hist_field *field, struct seq_buf *s)
 			seq_buf_printf(s, ".%s", flags_str);
 	}
 
+	if (field->buckets)
+		seq_buf_printf(s, "=%ld", field->buckets);
+
 	return !seq_buf_has_overflowed(s);
 }
 
@@ -3090,7 +3093,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		key_field = hist_data->fields[i];
 		if (!first)
 			seq_buf_putc(&s, ',');
-		seq_buf_puts(&s, key_field->field->name);
+		expr_field_str(key_field, &s);
 		first = false;
 	}
 
-- 
2.53.0

