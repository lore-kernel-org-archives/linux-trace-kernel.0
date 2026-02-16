Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA2A2E62B3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771249392; cv=none; b=J6ch3u11iy1IeJz5kTKlPd9TpO+70e6Hp7qHz/R6YZaxnfxNV/WPqqrhkqGfXRCd8tuyDpCGbz6jbLmL+mxUasHVU4ky3WOzJxp93NPtXM2UFo0WUqvSD5tApA66xgIMikuD111/bXui2mjBJd1IxeeI+GiSb0UZ64mWtWclpCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771249392; c=relaxed/simple;
	bh=6LFDVuA/OHDoi2ew3Yc8wiYv2QuvPmtPY+dggEg3SkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bpGWlz9FmMT2Lx3drEngcJiUU4pUE/OSuxEvCpB+wVVYdqG7/mchYdh6n83DxytAZDgNDFddvUyI+UiUpxqZWQp+F8/+ilfs7lypCxUkbeNXCT5XQZFn460OlrKQSVGby9/Wv7ZORlCYsbEShVFh3v2AOcSw+5exoz4NbVcV2p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gfExkZ7u; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gfExkZ7u"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-483770e0b25so26599585e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 05:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771249389; x=1771854189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KscRVRXxkytRt9vX8fO/qS5kgHQyf359sOu4xxSiI7s=;
        b=gfExkZ7u8G5hJcve3qrrt8XlKYPQ9NYe8VzQahMyzQmC+jDHP7KGjrEQfll/yZKBXI
         VqXLKaQ8lpfa/+NHSIscDCNegmuF3z/8yw2Dmvoq8gnR8JKttwNWcoGZC0doru4/qgXh
         i7PvN1R918uL7HoKEu/eXdMJoGKgGTesTB7uAd0sg09XMqukQFZrhQ03Bq1pVNYxSO0g
         G2PWmPSsoRsJLAnOLuhu1TV2WriP/Su9ROyKfE3dxaZKoWpcYxFhXJMms3Jzv+/I0ZHp
         p8wWibn8PzwQQn+XwIdvAJ5DrqyWsqBG4aiQV/zZx6rPTSgmISIywTDwYjhwDlew19dg
         q0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771249389; x=1771854189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KscRVRXxkytRt9vX8fO/qS5kgHQyf359sOu4xxSiI7s=;
        b=lWLYYZxpvqVY5fsDf0d5Lee+BuNLvDpKd9gzr1dCVWAQAe4BwJYxjKYYDaubTlspYq
         6B57PQf7P20eZ08myWkzCoGuKTaqpF84BZTa1bs0T4CIq7nmMf9+Qib4r8LByWU/f1ho
         aP41PgZDLsvj1h4VCpPJoCi7fgotY0x1shc2xk/p9RFXTs3+dwOzgJLM2//6HYbDvAOc
         +8o3OSlruUBNLRGLwHQv+ZqjBRHYWyhneGneZloHDyoGDGKmZedStwInDUhsWXFUxsni
         m8IkD3rzHS1b/pqstrBZm8nnbsi55sO7mu95eJoQfe4NEKfrOudml/ofEZzYzaHbTFh2
         38Qg==
X-Forwarded-Encrypted: i=1; AJvYcCU+pO+09/gzqzAkH3+Gf5iFL2Sy4aDSCQDCYjpDCEeKk45vI9vN6/0tgSBdFb8AIz7AQaLl9CjT8TNwwxMZmTEivo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm75V84iCYU4360b+wzv9QPTE8+pyrrpUzY2bWKFjZkJJcQmLE
	MKgSqPRsx8oyjGozv6J+h/aAe2K1uVajXGxQpFsZkaBMcU+yLhNof1Rn/KUqsd5vxoE=
X-Gm-Gg: AZuq6aILbou9E6atZLgLRBOjUrFZEtEYVAp64RypY9n5vk6yu5/+6W/PNi4Hbpyffbe
	A0YmoOSrtY3oNwh9BuKGUC5wiIGse5N4tH681rGOqgR1zvw+jB7QM+uEqlwUVLQU70GNAcwlkPI
	YWGV4H3ghaiagVjVKTSaox33uDCCn9IxPAAeJ3uEBNaRAslZKJmzjSGbbxDq1JbhlKxcXx0s0Ga
	cMdEYx6TuBlbD8WH3hWZAF9FZXSe6MQrKPchijPEvnqNq3AIVtnaY6fgox0jSAmFHj1MGixQ0qp
	tWYFgwB7UWZCviioPOAhB9xc/8V7wsJSkVtdsKbxYxyGZnz73cYAKpEQGN+3A75/mqZON4GHgJ6
	90nFeI0fgthjveJqVI7vPv5VXLMdP+hnSOmJwZG/FbqPxgZfY0ELNc7eX/F9gdk6sRSsFofewlv
	LnoXI0zjoSUeR91r2M90iKoAJXXa0KP8+myycK+pT/
X-Received: by 2002:a05:600c:8b4c:b0:480:5678:1fdd with SMTP id 5b1f17b1804b1-4837105240amr182277585e9.12.1771249389110;
        Mon, 16 Feb 2026 05:43:09 -0800 (PST)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6ba57sm22103738f8f.15.2026.02.16.05.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 05:43:08 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v2 0/4] Clean up access to trace_event_file from a file struct
Date: Mon, 16 Feb 2026 14:41:56 +0100
Message-ID: <20260216134247.1311631-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series includes several patches related to accessing
trace_event_file from a file struct. The first patch is a fix for an
edge case, the remaining patches are minor cleanups.

Changes since v1 [1]:
* Fix a compilation error when CONFIG_HIST_TRIGGERS is not set.
* Drop a patch that references the trace_event_file data in
  event_file_data() and keep the simpler implementation of storing the
  id in i_private.
* Inline event_file_data() into event_id_read() to enable adding
  additional checks to the former.

Petr Pavlu (4):
  tracing: Fix checking of freed trace_event_file for hist files
  tracing: Remove unnecessary check for EVENT_FILE_FL_FREED
  tracing: Clean up access to trace_event_file from a file pointer
  tracing: Free up file->private_data for use by individual events

 include/linux/trace_events.h     |  5 +++++
 kernel/trace/trace.c             |  2 --
 kernel/trace/trace.h             | 17 +++++++++++------
 kernel/trace/trace_events.c      | 17 ++++++++---------
 kernel/trace/trace_events_hist.c |  8 ++------
 5 files changed, 26 insertions(+), 23 deletions(-)


base-commit: cee73b1e840c154f64ace682cb477c1ae2e29cc4
-- 
2.52.0

