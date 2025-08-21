Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114EB2877F2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755754811; cv=none; b=JIeoK5kQdRy03BRAeLVhsNFvF6XxaJtoJzoQU+vP5jF9gZLDZN052I6iGqoxaHwTKh1IOxbzJSwAXp8xfdaLrkMMUoGvYmqw1cejJqK9A/7OSoME8ENR7eFKkxnqO38RC/pCP/mMCWNA6SCU8sMOXDyrdL6gAtFS3KsPerheuvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755754811; c=relaxed/simple;
	bh=J4Pt31yAdjggkVkhXKd4aEOD6o7lBlPQllPPBN6m1qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A6CPIxkdtNrcrY+lZobDBb9lnt3Rb+WDYsMsZnrJC7CF0fJJiyB9Ck2TZ8YrVtPqgUasarbNOx7xTCRDvVj5sSnm1P8K7Vzx0nnDt6vWd4nRF+/afofbX3LCEuc3eoyq1ACyzKYOsQwu6AgVOB/9pNlYJNjBgk90ELQ9qWY4lis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahs.space; spf=pass smtp.mailfrom=elijahs.space; dkim=pass (2048-bit key) header.d=elijahs.space header.i=@elijahs.space header.b=PrHBoU7K; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=OLE/uajL; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahs.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elijahs.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elijahs.space header.i=@elijahs.space header.b="PrHBoU7K";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="OLE/uajL"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=PrHBoU7KhIsI1vFvA5Nn0cV4QxXhIn3ovXrXf4BHzdSUdbNyISYzhFYJRgvnN4N4J3L6bB5TR3PhYuXKkQVvrx+fA1GL0n3VIEB0CQOdT1tILBDD9odVZXskXBnpqHtS643oGUSmHjn6NBxhwPGhvyUJQuqZqis2mTNafGEZz51XzK7IracmkUN79xZwfGb9KBTbB8SsNy7v9xHZaHOFxLjnLpuV4xgiLLDuiWmAPL/mqwA+UCnpN/gN1lAw7hsdEQFqYBOmCCMfxNcJjYiAvPGdQ4/Ujg5A1xjQcxlFia+yDablstqrpaARR86W5x6uOWZMcWqH+PHGDch0LShNhA==; s=purelymail3; d=elijahs.space; v=1; bh=J4Pt31yAdjggkVkhXKd4aEOD6o7lBlPQllPPBN6m1qQ=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=OLE/uajLqzUOzajd+clPqsnqyDpoNjKJUzem2VfUUNJZxmbudVdXTRJKqmPJL53YBWOGl+GZIahjTY4I/ExK6nuyHECropwVzc6R6RHfOb7GqD1wLZoQD0vmJC1t84qCpo5RjYjYMAZA7xQLxCk6RDMGURMwMT/TvE5f8YrVZiyFO0Uqs/HvKY0eetH2WUinsO3ry7UJ2d4K8Sm0O8PBcMZYGDdV2nmDrV5fxXZIoxkTQ6R1B3R15DuFpBqrbrn7QMGnO3PdzGfpBQN2KI1ZjWnv/DHJ1DxD3uLcdjycwzzsfNpe+HHOzLGelBas9r4rYnxKKQ+p4lBJh3YHjfo9hw==; s=purelymail3; d=purelymail.com; v=1; bh=J4Pt31yAdjggkVkhXKd4aEOD6o7lBlPQllPPBN6m1qQ=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 147366:4866:null:purelymail
X-Pm-Original-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -770991182;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 21 Aug 2025 05:39:31 +0000 (UTC)
From: Elijah Wright <git@elijahs.space>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Elijah Wright <git@elijahs.space>
Subject: [PATCH] tracing: move buffer in trace_seq to end of struct
Date: Wed, 20 Aug 2025 22:39:07 -0700
Message-ID: <20250821053917.23301-1-git@elijahs.space>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

TRACE_SEQ_BUFFER_SIZE is dependent on the architecture for its size. on 64-=
bit
systems, it is 8148 bytes. forced 8-byte alignment in size_t and seq_buf me=
ans
that trace_seq is 8200 bytes on 64-bit systems. moving the buffer to the en=
d
of the struct fixes the issue. there shouldn't be any side effects, i.e.
pointer arithmetic on trace_seq

Signed-off-by: Elijah Wright <git@elijahs.space>
---
 include/linux/trace_seq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index a93ed5ac3226..557780fe1c77 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -21,10 +21,10 @@
 =09(sizeof(struct seq_buf) + sizeof(size_t) + sizeof(int)))
=20
 struct trace_seq {
-=09char=09=09=09buffer[TRACE_SEQ_BUFFER_SIZE];
 =09struct seq_buf=09=09seq;
 =09size_t=09=09=09readpos;
 =09int=09=09=09full;
+=09char                    buffer[TRACE_SEQ_BUFFER_SIZE];
 };
=20
 static inline void
--=20
2.43.0

