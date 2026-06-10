Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E956406828
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096732; cv=none; b=ce7rFLSE7yNFWKND2AWTIQnusWUWepSIK+1l1gBlNjpeAwDNkqCpkfkEy6AUXW0fk7ivMsjbHDIPK02TF3unDhmVOLg/atqA+oqW+7yoe3R5ygnNai6r5cw5NEeX8padCI8wxPn5hY+aCe98lijZmYFj5bM9oLVymjQr2OqnT20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096732; c=relaxed/simple;
	bh=ZF8GkXJhrn5WBFDgFpOXp0w+uFsURwbZpQvppxKmyhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KVmbsDOji3XkG48gjBKA4WUE5uwHMwq8aUqzhL33FQwfCURatcDzVacfdcRNJvn7+pb1KTUnGLXZByiumm4hOvDsgzHOAtPPiy7vOo1sXK1zCd4Wmy5ox9lNRGWRsQZlB6vNFLlElDApYLR88/N5uKdGzflx4OWGth+L0eY/qcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=endfCvid; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="endfCvid"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781096727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CcT2S+HCWYeVvk3zyNq6HdAH0FzoIS+SmKZw90o5n08=;
	b=endfCvidP6c6XS3GMMOMyFRfYQY0ZVtXuM1E/u5LLQEjWuxdxcz3X51KgwJrt4veOvKNSf
	IcCToo+9wQ6be5BtsA9w8WaeG9VLxpXJxRF3/NKmiM076ddJccKVOMVwOmU/nJcnfkwjwB
	XFpIpMiv58bJyxBh6cIa80Ng4KTPuhk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-as4pKgxuNc-j9FbTcc-iJw-1; Wed,
 10 Jun 2026 09:05:19 -0400
X-MC-Unique: as4pKgxuNc-j9FbTcc-iJw-1
X-Mimecast-MFC-AGG-ID: as4pKgxuNc-j9FbTcc-iJw_1781096717
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EFA6195E91D;
	Wed, 10 Jun 2026 13:05:17 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.33.130])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65D6B3008B35;
	Wed, 10 Jun 2026 13:05:14 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [RFC PATCH 0/2] tracing/osnoise: Track IPIs
Date: Wed, 10 Jun 2026 15:04:50 +0200
Message-ID: <20260610130457.1304245-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: l00vjallfGCn_bzzv3rqj2X0S7Aqhsspoz6rn91Pm5A_1781096717
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi folks,

So I've seen a few times now reports of latency spikes caused by IPIs, usually
because of isolation misconfiguration, but only detected at the tail of end
e.g. a 24h timerlat run.

It's not because those IPIs are rare, but rather that they don't by themselves
cause a monitered CPU to reach the latency threshold, it's usually a combined
interference that gets us there.

I'd like to make it easier to detect such misconfigurations and thus IPIs
hitting supposedly-isolated CPUs. I initially kludged a timerlat option to stop
tracing as soon as an IPI was sent to a monitored CPU, regardless of the latency
threshold. It sort of did the trick, but Tomáš convinced me timerlat wasn't
really the place for that.

So here's IPI tracking added to osnoise. Two things worth pointing out:

o This only adds IPI count tracking, nothing about noise duration - this is
  already tracked as part of the IRQ noise.
o This modifies the osnoise Ftrace entry, I have no idea how acceptable this is,
  although the only real consumer of these should be rtla...

Tested with:

$ rtla osnoise top -d 5s
$ trace-cmd record -p osnoise hackbench -l 10000
  
Cheers,
Valentin

Valentin Schneider (2):
  tracing/osnoise: Sample IPI counts
  rtla/osnoise: Report IPI count in osnoise top

 include/trace/events/osnoise.h       |  1 +
 kernel/trace/trace_entries.h         |  6 ++-
 kernel/trace/trace_osnoise.c         | 80 ++++++++++++++++++++++++++--
 tools/tracing/rtla/src/osnoise_top.c |  9 +++-
 4 files changed, 88 insertions(+), 8 deletions(-)

--
2.54.0

