Received: from out162-62-63-194.mail.qq.com (out162-62-63-194.mail.qq.com [162.62.63.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6DC13634B;
	Mon,  5 Aug 2024 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.63.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722859941; cv=none; b=fItJPYcThtu57HrwHoEcILnuyiqcnjT2qx6Jx3kxHXbs/IWCAry7P6fMcuzvW+gFlzTpwNveUd7BMAP0ztgCoFSZtVAjOdf1GiT0E9uJ6tpbC6ntsFbYjVUR44qhokT8lso8mdKjL/34bBfSQoXVXjgPKGcl030v6f6rpnpRnpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722859941; c=relaxed/simple;
	bh=Qp11J6O8h+Au2NLWQbsXI+AfZKm4YW5Ca9Z9Tion6Rs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=V4A3BF62QmOnjrlR8HUkaYuc/EuG3w0u2uHdAGpRpftO0loWltHMsm01kZEco6oiHubwRHFxXbnGOgxDTdqSct1q3/NgxHOdAhqVNxy2CzjtmVwrvjRKP8r7vG0sQK90Dq23nSowR71iQAJ2g8Xdms69BnKbrxYfl+az7STNeH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jjsMdWDE; arc=none smtp.client-ip=162.62.63.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jjsMdWDE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722859632; bh=Y2rrQFMokNYbGpjkz/AFFe2SO8TaXfJsr5mUngwNA/Q=;
	h=From:To:Cc:Subject:Date;
	b=jjsMdWDEMTNkYCaOWD4VVWiEtqEYoDxf9ZXGws6FcVM7A4bhR8YcuEJU8XbjpQPUA
	 8AVfD+Uz1er34Neen43iD8h7BJlNDNWNXLEgLCwfpK+EijopkzDLOJN0afLSWtrlqZ
	 NXwh4SZIRRmg0IqPscCeQzC2368ibdd+PlbrTvWo=
Received: from localhost.localdomain ([101.82.163.228])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 9220F486; Mon, 05 Aug 2024 19:36:34 +0800
X-QQ-mid: xmsmtpt1722857794tbhq1pyes
Message-ID: <tencent_F4A7E9AB337F44E0F4B858D07D19EF460708@qq.com>
X-QQ-XMAILINFO: NkbC4iGUzta9XSUi1sBkV0QzuvHM43S0o+b5rIXMas1Vrm7RxL2UkWyCKE8eCM
	 KqgghwUnybUi+qTHHLpgM3DN5jWoS8tzjjn/szOqP7srKpLPJnVukuCGpnWODc+oFTPZofXST/3y
	 YVaeCfwjiqw03PXtH1RwTQFQNjxxQkhHva86Es/0xz6dgNMI8Tlnvu44MUWwvn9vSddtdRxTe1Pq
	 hMTgWRhzbYRWS9VrzwQfLYzEyrpNB6jSFtI4VD7mkFhPXDagRcaZ5nAzGyZgfePq0HtoePwlBkIK
	 YsSeWpB+oPAOeQ7zsaYXZDA/zHEEtJX/ZHvWde7PBlUlNG2OBdX35yZELLZ65aBNFgyZkgchgG8h
	 knCTpe0JpGxGOcv9MfymrbNgr7hkYCBbXGWusDxhRQVZwOhzRKnX+Zx7dnzw+1+dYyItOrb1xUj7
	 vPrs2SdcvaTQgxR/ihg0Lvlmdb4c96qDuOa88MW59Ebb+1wc4Hv603GmCYdM2S5QHUrQk5l9+sxF
	 E3RA1b5Zdb4eCIq1vxPQr+f6+RW3cK+UCmJmv/ho/JNylpZ+/z/kRPGcc9QYNK9dGgE/EtE93YXu
	 AIPT0TvJ0jKuM3elAwWp3YkfJkSD3wBlkQPE3vWtlC/+U/uisV+7gzxWflazxdPob5QwhdKkfWwq
	 RBuIvUVZeynYJJDn6GEJJYLt2dOeIIeC4F8vN/2Tvhqf0SYZEc50RMf77MLrOZHthoezZ0CDM7sb
	 fUid1Y1w9UN2T+0zPkz3X4dSgEUZ7RVMzseBbyeiE4uyTlvXcBwVTuFUIAWe1kWZQ/EyT4R7iHMy
	 35pDIMWovw7Ar1O2IrkAS1bKcEkUsgZU4jbfHg9yLoLigi7fEXg4mM34uojXkUJPz+/nF0y9qGuF
	 ZEtkDPigsTZfYlnjip9j/Jd4OQjUuq39tMCoPx5ApVwCLzpx+eyoie0RogIhgc0rgnuV8soUgMe+
	 Iw7jZXbkrOmddf9euy2I8V7fHLHiHyvDzXqrQmN4W2e9tJcJKzlZuU2L8JAsJ6UWRMeKLX3OVkOV
	 atVGKOB6U6V6Z31xjjMlWiKXIPnqmPxcj0jTHWOO4zjvhWw/9SKeuiMhH9rb/wvQds4sO/Eg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: 912460177@qq.com
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	JonasZhou@zhaoxin.com,
	912460177@qq.com
Subject: [PATCH] ring-buffer: remove ring_buffer_nr_pages()
Date: Mon,  5 Aug 2024 19:36:31 +0800
X-OQ-MSGID: <20240805113631.4118-1-912460177@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianhui Zhou <912460177@qq.com>

Because ring_buffer_nr_pages() is not an inline function and user accesses
buffer->buffers[cpu]->nr_pages directly, the function ring_buffer_nr_pages
is removed.

Signed-off-by: Jianhui Zhou <912460177@qq.com>
---
 include/linux/ring_buffer.h |  1 -
 kernel/trace/ring_buffer.c  | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 96d2140b471e..fd35d4ec12e1 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -193,7 +193,6 @@ void ring_buffer_set_clock(struct trace_buffer *buffer,
 void ring_buffer_set_time_stamp_abs(struct trace_buffer *buffer, bool abs);
 bool ring_buffer_time_stamp_abs(struct trace_buffer *buffer);
 
-size_t ring_buffer_nr_pages(struct trace_buffer *buffer, int cpu);
 size_t ring_buffer_nr_dirty_pages(struct trace_buffer *buffer, int cpu);
 
 struct buffer_data_read_page;
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 28853966aa9a..cebd879a30cb 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -692,18 +692,6 @@ u64 ring_buffer_event_time_stamp(struct trace_buffer *buffer,
 	return ts;
 }
 
-/**
- * ring_buffer_nr_pages - get the number of buffer pages in the ring buffer
- * @buffer: The ring_buffer to get the number of pages from
- * @cpu: The cpu of the ring_buffer to get the number of pages from
- *
- * Returns the number of pages used by a per_cpu buffer of the ring buffer.
- */
-size_t ring_buffer_nr_pages(struct trace_buffer *buffer, int cpu)
-{
-	return buffer->buffers[cpu]->nr_pages;
-}
-
 /**
  * ring_buffer_nr_dirty_pages - get the number of used pages in the ring buffer
  * @buffer: The ring_buffer to get the number of pages from
-- 
2.25.1

