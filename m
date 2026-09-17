Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531F33E40F0
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Sep 2026 04:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621168; cv=none; b=Xv/Lxp2R4tRsaZaPR+3FlktXUVGLIdvfZNo/f0MOkUquQ+qUTcVEvwVfE3GE29iHcr+FPhKorWM3EIsg6NAdvGAfvl7LhH0LLdYkceGMlq4BLKEH8UAzt11qBI6IIO7tE+Brd0V4ZoUednycjBLmzmgSQ7HDXQxc5JLWMZ4KngU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621168; c=relaxed/simple;
	bh=gs/PzXTul/jmGqr89QmFKk4XxkukNlwtIYTEA5jC17A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fKGDOSzCk0DeLb0dmhpYic9iyLWSkDpDjbn/BZHfIHW3aUNbw+V8tyqKIhI6XhfKatg7mwET3MfmiSgtKoDe8swZKXuFlvBX4HoUT3GOEGRZGMu6ri0QlKH721un/C1B/UtVoNDWmu6S5gffvera5ux0Cx2Fol5mPzRK211Kr3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5+w15Re; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5+w15Re"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f0135fso4058455ad.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 21:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789621167; x=1790225967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IGfnNLxYgSH4WAPgBhFsDBjnPoyc1JaktTPCwgLw28c=;
        b=Y5+w15ReCdS9fKgTSy1KUiImQdj1wghWettiSOPIp9BhgnW629xCipYl6xqJ+ALEtb
         ch2DD5c4SkZF2GgqyPAKlNJwYoTqLjxyHCiCCaJnnh5UBi3HwEXtxYaVUuGHjjXAesst
         0HXMx46m8/blrA3NOLvRZbfDzDCHqSTBwa5aYwzXeVpq625oPwXLtdMvt/BtCkvJR4BN
         QoEoh6Blvgc5WAK0UHJte6WnsXxtBx3BgB7tqhS6ztoXeaRZ89ebcgCt06+x+KA9zF8d
         6M6XZaJcf4APamDXjczjen2Udooq0RTjkOZbaseg9KflJqYvIOcVY8l8qdiS85RtK4vv
         xKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789621167; x=1790225967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IGfnNLxYgSH4WAPgBhFsDBjnPoyc1JaktTPCwgLw28c=;
        b=zhh28018Uz52yBr39QUcAUz/rapo9w/nc/1UsjQl/T+OhOTn0YnCrKaOFC0GDSCH1X
         9aX9BnVV3fk5SqpwANHqQqaYCLqlQ5EhiOX2dyVI9rc8Zq2jvTwpynpMAhWo3kEYSbdc
         aB/T8agzRyLOmuWHeXpLD4TghaZG9RHMH9NnZsAKQjCTD463Lp++5RDQ+EB+8l5x294C
         gawdTq3VmLItt07UG8EPSeorNPQUC99g0J1YRolJ+iylT8aR0JNlzkly4Mt5AHiPhNVb
         8eiUc+WRm1oxDbG+LIFXwS+1IIOW1IKpXwv7Ss2oZbGpZv2ugJvSDvBm7ax+vbZK8VcY
         CmIA==
X-Forwarded-Encrypted: i=1; AKwUvBysk6wP9dKme13lUG8l+KI85x3KaA3810FWzJdmW1lb6GRG0gLYnT1DxaK3MB0QRQMA1AMqsvrFpi8zti8hdgedwIQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l6HP1vEMqFRtREcophBGww5AW9lwxaxCLyWds/SjihlSRx8Gz+
	a95WbTc931aY5i+duE/iKMStaIRpqfB9IcT8XX01sqTMJCItzuiqrDE=
X-Gm-Gg: AYBFou34UGTqNZgFG9mNlPcLWEEkW5I8kuU/6VZYplCy17nYPVhOEpltfli+R8/Isfr
	FfbT7httAI2OabCOFiIUpVpjW34O3L9F2cvjL6BDBZN5LtmrBlueVMvdJP7n0oUFVqldAyzkqDn
	RA1zh0xDRV6bOm/LbuXVdqiFchIy2ZJeuxnxEuMeyKuaU2Y1SL/x/0Sxp35/dcz1WGNJetu5k7/
	dBd8S5uqNYsdEV0D0bdZI4Mpcf5Gb4qAEJh3n1s+QGCF0R8P7meMIxnTZxciHPmx5RYr7W3d6c9
	NE6PKW+A9MGB+6FvW+rcJxnC+7CI8azvSc6V6kLbJ/0TSpSopHUcJ/NKBmVXzrki9v0S8PZirVm
	2kZpZWEqVaaHpob7yWm1tKQSK06Vz9HaCOok1hMJm4IPzbrjhDcCDJwN1Bafn+KytrjbSmG116C
	Eb3wPRU6AkNcO9BqG2hYluSR4XwaIF0lEzjb6aksvFGIbqT2K1uSHPbwAxI7+EdPbPCON0PVW1E
	XR/Ig/g7q4Wnc2pZcS9qnY77jlQLpf4I2wW3Q==
X-Received: by 2002:a17:903:1b67:b0:2cc:6018:f030 with SMTP id d9443c01a7336-2dd8e51df8amr114931955ad.14.1789621166006;
        Wed, 16 Sep 2026 21:59:26 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:b6f9:c198:e14b:34c1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89ee0e8fsm20410005ad.53.2026.09.16.21.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 21:59:25 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	namhyung@kernel.org,
	zanussi@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH] tracing: Print a signed histogram key as signed
Date: Thu, 17 Sep 2026 13:59:18 +0900
Message-ID: <20260917045918.370993-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A histogram sorts its rows by the key named in sort=, and for a key over a
signed event field it sorts them signed: create_tracing_map_fields() picks
the comparison function with

	else
		cmp_fn = tracing_map_cmp_num(field->size,
					     field->is_signed);

hist_trigger_print_key() does not look at is_signed at all. Every numeric
key is printed with %llu, so a sorted histogram over a signed field comes
out looking unsorted. syscalls/sys_exit_lseek carries "long ret", which
SYSCALL_FIELD() marks signed and which is negative on every error:

  # echo 'hist:keys=ret:sort=ret' > events/syscalls/sys_exit_lseek/trigger
  # echo 1 > events/syscalls/sys_exit_lseek/enable
  # (five lseek(2) calls returning -ESPIPE, -EINVAL, -EBADF, 0 and 100)
  # cat events/syscalls/sys_exit_lseek/hist

  { ret: 18446744073709551587 } hitcount:          1
  { ret: 18446744073709551594 } hitcount:          1
  { ret: 18446744073709551607 } hitcount:          1
  { ret:          0 } hitcount:          1
  { ret:        100 } hitcount:          1

The rows are in ascending order and the numbers are not, because the three
leading ones are -29, -22 and -9 rendered as their two's complement.

Take the rendering from the same place the sort order comes from: the event
field when the key has one, and the hist_field itself when it does not. The
same histogram then reads

  { ret:        -29 } hitcount:          1
  { ret:        -22 } hitcount:          1
  { ret:         -9 } hitcount:          1
  { ret:          0 } hitcount:          1
  { ret:        100 } hitcount:          1

A ".buckets" key stays unsigned here, and not because it is right.
hist_field_bucket() divides as unsigned, so the group holding S64_MAX also
holds S64_MIN, reported at

  https://lore.kernel.org/all/20260914054614.82A9B1F000FF@smtp.kernel.org/

Printing that group signed would name a range that does not contain
S64_MIN, so the grouping has to be fixed with it, in a patch of its own.

Fixes: 7ef224d1d0e3 ("tracing: Add 'hist' event trigger command")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Independent of "tracing: Clamp the printed end of a histogram bucket at
U64_MAX",
https://lore.kernel.org/all/20260914132346.2234731-1-donggeunyoo.kernel@gmail.com/,
which is still pending in the same function: the two touch different
branches of it, apply in either order, and give the same tree.

QEMU x86_64, v7.3-rc3-82-g238650ef6c7c, one kernel per arm and one
initramfs.  Sixteen histograms, over syscalls/sys_exit_lseek and over a
user_events record carrying an s64, a u64, an s32 and a u32 - one per arm
of hist_trigger_print_key() that a key can reach.

  changed   keys=ret:sort=ret
            keys=sv,uv,s32v
            keys=sv:sort=sv
            keys=sv+0
  same      keys=uv+0
            keys=u32v,common_pid
            keys=sv.hex
            keys=sv.log2
            keys=ret.buckets=10
            keys=sv.buckets=10
            keys=sv.buckets=8
            keys=s32v.buckets=10
            keys=sv.buckets=10:sort=sv
            keys=uv.buckets=10
            keys=u32v.buckets=10
            keys=common_timestamp.buckets

Every histogram that changes is a key over something signed; the other
twelve are byte-identical.  The values written cover zero, both signs, and
both ends of the 64-bit range.

 kernel/trace/trace_events_hist.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8af97fd4ee2d..b128fee0af24 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -279,6 +279,14 @@ static u64 hist_field_pstring(struct hist_field *hist_field,
 	return (u64)(unsigned long)*addr;
 }
 
+static bool hist_field_is_signed(struct hist_field *hist_field)
+{
+	if (hist_field->field)
+		return hist_field->field->is_signed;
+
+	return hist_field->is_signed;
+}
+
 static u64 hist_field_log2(struct hist_field *hist_field,
 			   struct tracing_map_elt *elt,
 			   struct trace_buffer *buffer,
@@ -5568,7 +5576,11 @@ static void hist_trigger_print_key(struct seq_file *m,
 				   (char *)(key + key_field->offset));
 		} else {
 			uval = *(u64 *)(key + key_field->offset);
-			seq_printf(m, "%s: %10llu", field_name, uval);
+			if (hist_field_is_signed(key_field))
+				seq_printf(m, "%s: %10lld", field_name,
+					   (s64)uval);
+			else
+				seq_printf(m, "%s: %10llu", field_name, uval);
 		}
 	}
 
-- 
2.53.0

