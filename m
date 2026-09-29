Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4029C519910;
	Tue, 29 Sep 2026 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790678445; cv=none; b=g1cTpq8Nq5f67smr5sqfdWHEJdQZMEx54VNdCrMeMjwFqRWIQrA8b2pPnJRbQhFevrngMZj58EKTXQe3b0EuayWL9joGC8o73Krf1OLFkyhJOkC76PbGbJFkOvmQP0/9wP+wT8XgGWSJ+3GvcTJz+Sbq0lwOu4wn5R1qdq6kK2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790678445; c=relaxed/simple;
	bh=TJ5pZKKCwVcM9PGDihDRGowhaumFtB3EqI9dlXaepLg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dQN9AAP6heNFa5ajujowQm3IH+qvwWEMDHlXzVWWxr92Hhc/2kJC7CyvfzzM4FxMYWhJTeZh88keNPEFA1eeiQarnY82AG8XjwZ7yddFsUZduDIHTxaViKew8y+llXaAkEnigyV8aJtsRT5Sk2aIBNAcIWmA7gnMFSKTmKJBHXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hvF711rQgzYQv35;
	Tue, 29 Sep 2026 18:39:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 543F340573;
	Tue, 29 Sep 2026 18:40:24 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgBnmxKQlbtqSv5eCA--.24675S2;
	Tue, 29 Sep 2026 18:40:24 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH] tracing: Fix hist trigger timestamps for buffered events
Date: Tue, 29 Sep 2026 10:40:15 +0000
Message-Id: <20260929104015.1689921-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnmxKQlbtqSv5eCA--.24675S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr4xCFWUGFWDXF1rXF43Wrg_yoW5tw48pr
	yYkr43Kr1Dtr429anxu3Z5XryrK3ykJrZruF4UAryay3s5Wr1xXa17Kw43Aw15tFWxt3s0
	y3Wj9347G3yUXFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZYFZUUU
	UU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Syzkaller triggered a WARN_ON_ONCE(!nest) warning:

  WARNING: kernel/trace/ring_buffer.c:821 at ring_buffer_event_time_stamp
  Call trace:
    ring_buffer_event_time_stamp
    hist_field_timestamp
    hist_fn_call
    event_hist_trigger
    event_triggers_call
    __event_trigger_test_discard
    trace_event_buffer_commit
    do_trace_event_raw_event_sched_switch
    trace_event_raw_event_sched_switch

The warning is probabilistically reproducible and is related to syzkaller
executing the following commands:

  echo 'prev_pid == 999999' > events/sched/sched_switch/filter
  echo 'hist:keys=common_timestamp' > events/sched/sched_switch/trigger

The specific triggering process is as follows:

CPU 0                                           CPU 1
(context switching)                             (echo 'hist:keys=common_timestamp' > \
                                                        events/sched/sched_switch/trigger)
do_trace_event_raw_event_##call
  trace_event_buffer_lock_reserve
    if (!tr->no_filter_buffering_ref &&
        trace_file->flags & EVENT_FILE_FL_FILTERED)
        return entry;  // return directly
                                                event_hist_trigger_parse
                                                  hist_register_trigger
                                                    tracing_set_filter_buffering(file->tr, true);
                                                      tr->no_filter_buffering_ref++;
    __trace_buffer_lock_reserve
      rb_start_commit
        local_inc(&cpu_buffer->committing);  // skipped and not executed
  trace_event_buffer_commit
    __event_trigger_test_discard
      event_triggers_call
        event_hist_trigger
          hist_fn_call
            hist_field_timestamp
              ring_buffer_event_time_stamp
                nest = local_read(&cpu_buffer->committing);
                WARN_ON_ONCE(!nest)  // trigger warning

The root cause is that when an event file has a filter attached and the
hist trigger has not yet been attached, trace_event_buffer_lock_reserve()
writes the event into the per-CPU trace_buffered_event temp buffer instead
of reserving it in the ring buffer, so cpu_buffer->committing is not
incremented. When the event is later processed at commit time by a hist
trigger, hist_field_timestamp() -> ring_buffer_event_time_stamp() sees a
zero committing count, triggering WARN_ON_ONCE(!nest).

tracing_event_time_stamp() was added by commit d8279bfc5e959 ("tracing:
Add tracing_event_time_stamp() API") for exactly this case: if the event
is the per-CPU trace_buffered_event, it returns the current ring buffer
timestamp. But it never gained a caller. Use it in hist_field_timestamp(),
so that a hist trigger that races onto a buffered event records the
current time, which is only marginally later than when the event was
recorded, instead of warning and recording a bogus timestamp.

Fixes: b94bc80df648 ("tracing: Use a no_filter_buffering_ref to stop using the filter buffer")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8af97fd4ee2d..89be3139f8e9 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -873,7 +873,7 @@ static u64 hist_field_timestamp(struct hist_field *hist_field,
 	struct hist_trigger_data *hist_data = hist_field->hist_data;
 	struct trace_array *tr = hist_data->event_file->tr;
 
-	u64 ts = ring_buffer_event_time_stamp(buffer, rbe);
+	u64 ts = tracing_event_time_stamp(buffer, rbe);
 
 	if (hist_data->attrs->ts_in_usecs && trace_clock_in_ns(tr))
 		ts = ns2usecs(ts);
-- 
2.34.1

