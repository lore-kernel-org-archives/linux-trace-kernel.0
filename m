Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2483655D6
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 06:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761012; cv=none; b=Lg5BQOYHmnszZntDP6bUrk9pmeJKGCM52z9wy/CGeduF6nj38jUMc/b3IMYBkGPqvjUZ8IWiaJNFqan+zRT1yA0wpfGscqbmdhu4smqm0MHvWoQP6tesENjP/xdy/Bz1A5j0eUVOvYUUnJK1GjzN1efblQRblsJX+S1Szj5vzTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761012; c=relaxed/simple;
	bh=Nt2lC421KGj6k/zMmxzDYBaPvInT84oKibKrryL2NgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lwjw8CJx8HG88fRLjEmsJlhzpYhuCWX/dCbTlrezgyxOsQgrWOzoFn3At9qYzIabLtAsu3lKgDWgWC3lip2WYKdu5hmwRDYWZ4wPOu7f3byOSWi1dZ0qZJ87sePsj55g8QDEihhHM9gMd9JyaLYALawhZBKnzk2aQfkprJJaxWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqIkmWhY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqIkmWhY"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d8fd3b729dso25399785ad.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 06 Sep 2026 23:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788761009; x=1789365809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QIQIslv7KrGu5ytY96/0sD/t/rOZ560Khhwx/pFUmS8=;
        b=IqIkmWhYdap/PYgi0NJT8ZPMreqP6jQBGbsCN4qblOqewzUQ7UW4MaQtF/ntsdR9u2
         3M0qz9mFW4yAmaMJwIdIbyon5EDv2BY4tO4mXQMpGyU3JVFDjTeMWZPRGgTcdE9yaCRs
         ics4SQqtWNhQmDoDFCqLB0xtpOchIOUHQ7K2kf/Rtp28+9lheXo+oUURYT9Kmvm73AIp
         CLNwDIh9iuCDplj9xWJycAGA37xeANpz8HmFVXrQJ/J4Ru3Rd/DivGHhg3mDv0oyF5LS
         4sKE3xaZt08u0bWL+r7ofK96DObbiZTq7KaFtOZlUCv9X9l3ad3C6IQj6pD9jqRRz6fx
         LI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788761009; x=1789365809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QIQIslv7KrGu5ytY96/0sD/t/rOZ560Khhwx/pFUmS8=;
        b=i1UT/ERKJ4pbuiZoqNCRz853iGeNI1Pb/xTXiEY8a9NlZcSihc5OAl8+DkbBue8at5
         A2u1hwHTcCyLE5vES7EZrMJ22pvCRx+9bvZ11+gaqy0ujZoJsdbNjM4dt+sPZuNwSASN
         hfr7dDDZX3G7uRpHv3FTC+/o7Nx3zLPnjR3JbU09afBZGqgV36ZY+4bdZ4NZ3buz1wyh
         vwPOejdJ02JnrCKfO7yfmFcpieSNXaxoICk9QEfkBowHIqd3uhYCgrfo38yi0voxU7AC
         y2wuBzFVogQawoLQ94nLpWieqUIAyq8fYOqGFh7rC4S1tKhscPr0AckHBmGkdKJPuuj8
         4VXw==
X-Forwarded-Encrypted: i=1; AKwUvBwum16VMSvATLskntAyU6B1cVCkWX2PykzMRl/vChzFQUwwNzrtqQL+QK1A2eccyBMuEubbSawzNFJW+BSVRPHro0w=@vger.kernel.org
X-Gm-Message-State: AFuF++nca5x5XB+SnopXjiulV7QUfCCj+5fpuCzGMAqfr1BMqfIm+S0l
	w2Jx+MsQ0J3pb2b1MjeO4tDhVwYABNs5egQ6+SbgEnEBusFrtJzpJOCEM/+eNPsDew==
X-Gm-Gg: AYBFou2FDLqIoxBwJftYPvqwRF3ZhidLc+tGUJ4Ueb3t1K1MqhxuSrjtMtNaT2/3A/m
	DPXlSy/ZH8qYPXXMvoXi0UreIaa7DMcHaFhXmJJpNpz9rpNjV7sEw9Kye7Z59GBZ+yXRSiumHDN
	3TVdgCpDpdiFm0C9H2GA+52ysnoBp5IZURK5zCWU1mDQUA1bOoISWKGDYcFGe76p00GMJzunmdP
	1PcI7XAq0z5sUhayb8MDxsqas81C3Ww0M0KH38NYuA1yj/45X9XV0ZF6sPlVUT66kDfQzDlT4Fj
	0W0SW5Z4sEEia3XgfKNoy7isWALFMtrIRDk9GDJEwwmHHJgUSOSRCHG/Ag4jj5nLeptvpAi6Mi+
	w489om+tTR8xN83whf1uock3xIfcEezl/fY6NEEL7oPI4eqIeGlewhCTqQR9IVcoe+CUudVc80a
	YwqZ9Mu6VO9TiT4hG8UERVp8DOvqGJXaMUEepSDZMTklEsEYS0H8R7+JlLEWuHyRvMW7sNjYpuv
	gLuaUdAM6d8bbcrAA==
X-Received: by 2002:a17:903:3810:b0:2d6:3c22:99bf with SMTP id d9443c01a7336-2db124afcefmr323518875ad.9.1788761008657;
        Sun, 06 Sep 2026 23:03:28 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:c773:5f09:906c:a72b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1499dad4sm39669455ad.55.2026.09.06.23.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:03:28 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH] tracing: hist: keep the entry count when the stats allocation fails
Date: Mon,  7 Sep 2026 15:03:23 +0900
Message-ID: <20260907060323.480728-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

print_entries() uses n_entries both as the number of sort entries and as
its own return value, so the -ENOMEM it stores when the stats allocation
fails overwrites the count that the cleanup still needs:

	n_entries = tracing_map_sort_entries(map, ...);
	if (n_entries < 0)
		return n_entries;
	...
			if (!stats) {
				n_entries = -ENOMEM;
				goto out;
			}
	...
 out:
	tracing_map_destroy_sort_entries(sort_entries, n_entries);

tracing_map_destroy_sort_entries() takes an unsigned int and loops up to
it, so -ENOMEM arrives as 4294967284. It walks an array of at most
map->max_elts pointers and calls destroy_sort_entry(), which dereferences
and frees, on whatever lies past the end.

Reading the hist file of a trigger with a .percent value, with that
allocation forced to fail:

  BUG: KASAN: vmalloc-out-of-bounds in tracing_map_destroy_sort_entries+0xa0/0xb0
  Read of size 8 at addr ffffc90000045000 by task init/1
   tracing_map_destroy_sort_entries+0xa0/0xb0
   hist_show+0x6f7/0x1df0
   seq_read_iter+0x2b8/0x1190
   vfs_read+0x176/0xa40
  The buggy address belongs to a 4-page vmalloc region starting at
  ffffc90000041000 allocated at tracing_map_sort_entries+0x5c/0xd50

A few pages further the fault is fatal. The registers at the oops confirm
the bound: the loop's end pointer less the array start, over the pointer
size, is 4294967284.

Return the error in a separate variable and leave n_entries holding the
count, the way tracing_map_sort_entries() does on its own error path.

The stats block is only entered for a value carrying .percent or .graph,
which __create_val_field() has rejected since v6.3, so this cannot be
reached in mainline as it stands. It becomes reachable again with
"tracing: hist: let values keep the percent and graph modifiers", so it
should be applied first.

Fixes: abaa5258ce5e ("tracing: Add .percent suffix option to histogram values")
Cc: stable@vger.kernel.org
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Reproduced under QEMU x86_64 on 1fc5a74b108f, with the percent/graph patch
applied so the block is reachable and with the stats allocation forced to
fail. Before this change the read of the hist file never returns: KASAN
reports the vmalloc-out-of-bounds quoted above and the kernel then takes a
fatal page fault. After it the read returns, the histogram prints its
header with no rows, and KASAN is silent.

Link: https://lore.kernel.org/linux-trace-kernel/20260907052113.430818-1-donggeunyoo.kernel@gmail.com/

 kernel/trace/trace_events_hist.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 963e0d6b61fd..67f324d7dc78 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5690,7 +5690,7 @@ static int print_entries(struct seq_file *m,
 {
 	struct tracing_map_sort_entry **sort_entries = NULL;
 	struct tracing_map *map = hist_data->map;
-	int i, j, n_entries;
+	int i, j, n_entries, ret;
 	struct hist_val_stat *stats = NULL;
 	u64 val;
 
@@ -5700,6 +5700,8 @@ static int print_entries(struct seq_file *m,
 	if (n_entries < 0)
 		return n_entries;
 
+	ret = n_entries;
+
 	/* Calculate the max and the total for each field if needed. */
 	for (j = 0; j < hist_data->n_vals; j++) {
 		if (!(hist_data->fields[j]->flags &
@@ -5708,7 +5710,7 @@ static int print_entries(struct seq_file *m,
 		if (!stats) {
 			stats = kzalloc_objs(*stats, hist_data->n_vals);
 			if (!stats) {
-				n_entries = -ENOMEM;
+				ret = -ENOMEM;
 				goto out;
 			}
 		}
@@ -5729,7 +5731,7 @@ static int print_entries(struct seq_file *m,
 out:
 	tracing_map_destroy_sort_entries(sort_entries, n_entries);
 
-	return n_entries;
+	return ret;
 }
 
 static void hist_trigger_show(struct seq_file *m,
-- 
2.53.0

