Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698035;
	b=YPWcVeM7oU++qX4grOuyL8ll8/uN9lgeq6EwyhfU/WVBo8gBt8lJvPovOt9deUIekv9Y
	 5Oq2Ab71V92+uCdQ4w1qjJ1+J8t56JC+dQ6r4bBFkhvf9g7LO8iaalSjqvFIfZXfdGHg3
	 RjNGNYg6BzovIl/ckXi+RzTPSgieRBIvJRbed61OqO1xcE2KtQBBYH+Pn2hZxdYob710Y
	 QyjS4aNTNtNrSqmUWnVy/fablS16Fy2YDc7fvGPsGx7UB1PenlVT5qc1jwyJ9peT+3mR4
	 AaNYiSKyrT8K4xl0VgraQFYPlL9TJ+rh4YODruj1ngNFDSbhiTGuSbY0T7gAvZX2umQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698035;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=fkK1uCwwzUMb2PiZqxaXOt1gFq6un0zd6u+YCXzwUoU=;
	b=Hxuz3RuueQccLo3U0nqGuhjHRYk2nUTb0VJK9fx1PX/3eZG+PfIukaxOEudC2lkunxKe
	 /5zuwAmEZ0ISDYi3moSgvUMVWhhHWQ3BGf4q+iyujV5vfsBqYBJomU31xDboHga8fZfgZ
	 qXlJ3lR6ES6hdpKzaDHkSbOQl7A5D1R9jzpNUo4gnX8sRYTYvQG1PdfiZVU3UBhpgYZDC
	 gbXti1Vd8sHwVBCJIaFF/61ojAPw+2h5brrrmWEEJLQ8QNor4hSITqgnkHVxHlsxwT6uX
	 iTU7zQrEYhSW5sG2G/Ze1CQ7uMC0EpPXvbPXzS6j0iLyZKVAmrY26Tilo+G0ZmrF3Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JvYsYyKe;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295C606A685
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 13:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8295C606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JvYsYyKe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795698033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkK1uCwwzUMb2PiZqxaXOt1gFq6un0zd6u+YCXzwUoU=;
	b=JvYsYyKeSCiVCG1ySsVRpg6LLZzhURKtEg3kniCIbJALXJcKBwTXjbDB51xIkeiQGABm44
	wAGb2obmdxuOYwD3572TuyvCCD6I4oNbc+W8g3vvnMFjoRRfCiGWu/2lgt1wlCnOWcYQra
	GxpllBKv21MQfonvtKjJil8ifNTS1Vk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-U5FQP9DrOD2qBgWwCmUoPw-1; Thu,
 26 Nov 2026 13:00:27 +0000
X-MC-Unique: U5FQP9DrOD2qBgWwCmUoPw-1
X-Mimecast-MFC-AGG-ID: U5FQP9DrOD2qBgWwCmUoPw_1795698025
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C2BD1800349;
	Thu, 26 Nov 2026 13:00:25 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B833E1801977;
	Thu, 26 Nov 2026 13:00:21 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v3 02/18] tools/rv: Skip empty pid error in selftest if command failed
Date: Thu, 26 Nov 2026 13:59:48 +0100
Message-ID: <20261126130004.127155-3-gmonaco@redhat.com>
In-Reply-To: <20261126130004.127155-1-gmonaco@redhat.com>
References: <20261126130004.127155-1-gmonaco@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: YJVffcwVWjN7lWGBfEAjY8QLabUhJrZGh2DbNsofIr8_1795698025
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Some rv userspace selftests rely on the pid of the rv process to match
with the output and fail prematurely in case the pid was not found.
If the rv process failed, however, it's likely it will terminate before
catching the pid, and the test reports empty pid ignoring the error that
caused the process to fail.

Report empty pid only when the rv process succeeds and continue showing
exit code and output otherwise.

Fixes: 92f0ce552990 ("tools/rv: Add selftests")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/tests/engine.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/verification/tests/engine.sh b/tools/verification/tests/engine.sh
index cfdf2180aad8..4dad43b0b822 100644
--- a/tools/verification/tests/engine.sh
+++ b/tools/verification/tests/engine.sh
@@ -60,8 +60,9 @@ _check() {
 	failbuf=''
 	fail=0
 
-	# Suppress any other error if a needed pid is empty
-	if [ -z "$pid" ] && grep -q "\$pid" <<< "$patterns"; then
+	# Suppress any other error if a needed pid is empty and there was no other error
+	if [ -z "$pid" ] && grep -q "\$pid" <<< "$patterns" \
+		&& [ $exitcode -eq "$expected_exitcode" ]; then
 		result=''
 		failure "# Empty pid for $command"
 		return 1
-- 
2.56.1

