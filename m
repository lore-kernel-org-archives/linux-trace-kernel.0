Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2F83C7E1B
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jul 2026 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783510062; cv=none; b=Mk1IzBZ5tmEY+LfZszqfBVRiqy5ptBqCh5OkQTX/7NyE61v1sLCwRag86St8q+DS3tbmJ3WEu8BAsSPurSU5PSdky+JnZawHcL4JZc0NkhlzIbwNg1hjVqxiD2yJaVWNFY1IV4mWRYVDKQfksgtGkXuBW1qJHplTJOlifKYxxgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783510062; c=relaxed/simple;
	bh=xmAHI/k+nPriQkdrAQxY3SY26007WaJnBn71CbUeArE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=utfGx3UPIHbNnRnKcEnv3j+c+WHLLyjpus0pLiaV0KCSjImgaMWvk696hLZgeoPejj7+gK2y982jZ7ecJRd2MhL6rbwzxv1ClO+LW+wef3e33yGX4puDlN5ccVTAebjN7FOpDAWUIgzymr6pXFPboMRdE3Jorv3/dAGx6uXQuec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bc+q7vZr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bc+q7vZr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783510060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W8PShlFvSdR72NUOp5LNGaOaUStE70hQiZeT02/HxHk=;
	b=bc+q7vZrNboN/bC125UF3BY8eIlCdKSbUvHaGjox6qslvUHFAShlvrLXXQz1ihrmTtOh+9
	SYTThdw1eOSAfoqzbRP276NHqXYqBZ9dcvOFYDkZVBSJ3n0CcLSI18+n1+VfvTQm0bud7f
	RkD80Z1pjsZ89BBc7GjOs2NTtrF/mR0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-B97TU816PyiDhePvqlwIcw-1; Wed,
 08 Jul 2026 07:27:37 -0400
X-MC-Unique: B97TU816PyiDhePvqlwIcw-1
X-Mimecast-MFC-AGG-ID: B97TU816PyiDhePvqlwIcw_1783510055
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E4A5180060C;
	Wed,  8 Jul 2026 11:27:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.127])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4649318005BB;
	Wed,  8 Jul 2026 11:27:32 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andreas Ziegler <br025@umbiko.net>,
	Bastian Blank <waldi@debian.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [GIT PULL] RTLA fixes for v7.2-rc3
Date: Wed,  8 Jul 2026 13:24:35 +0200
Message-ID: <20260708112435.187765-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: S95pbcpq9aGoB9GfjpFvpNfriBmRRxbfGaJAgNTzSUA_1783510055
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Steven,

The following changes since commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda:

  Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tglozar/linux.git tags/rtla-fixes-v7.2-rc3

for you to fetch changes up to cd9993d22a577339a93dcb401574e874ea29b143:

  rtla: Also link in ctype.c (2026-07-08 10:38:18 +0200)

----------------------------------------------------------------
RTLA fixes for v7.2-rc3

- Fix missing unistd include

A missing #include <unistd.h> broke build on uclibc systems.
Add the include to fix it.

- Fix missing tools/lib/ctype.c dependency

RTLA links tools/lib/string.c as a dependency of libsubcmd, some of its
functions require _ctype. Link tools/lib/ctype.c as well, to fix build
without GCC LTO.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>

----------------------------------------------------------------
Andreas Ziegler (1):
      rtla: Fix missing unistd include

Bastian Blank (1):
      rtla: Also link in ctype.c

 tools/tracing/rtla/Makefile     | 14 ++++++++++----
 tools/tracing/rtla/src/common.c |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

