Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDD554279
	for <linux-trace-kernel@vger.kernel.org>; Sun,  7 Sep 2025 02:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757211828; cv=none; b=TvqwQSgjfu0tPtHpoyi9/vfMOR1ZAhly0kbJnvMQoJIii1cZF4pP9qrCosb3SrsbU1EJyejfgWiUbuXN/iafeoZG8RdO0eX6AKXg3H/sKxazFw7GLD46dl3NrF6+FrZ+JpNYtDYCFs47mqZ+fZ75X07wLBXKMKQJorYS6y5P2+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757211828; c=relaxed/simple;
	bh=fU2/QRBNloyWHPZwDtUtgN8BMiLrbJ7ALDq0Kza2HSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=sSWKga8nDLdIBWFJHg8eN5sFprHlmSae2i0Oq8woZur87+SgGnNj+QqRxRVWqMO/BfWJJaOCCXWKEVe0hbx8UqfUxwoNO0cn2uBvoNcQ+oR409PqVkzdOKiUL+8ZH6wCHBw5NC7CuPG/8JIGdDnRxRGDAMIWdExoK+OXXp3wF9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HVbC/kIS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVbC/kIS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757211824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eKta5jItXUnhLWu5FlkjEeVXw/iB1AnfiY60QC5jWSY=;
	b=HVbC/kIS/rSLZH0FVCWtifV2si6hKp2GV+e31vEEFcChgECj5JmHzt/zmmigijKu+20Mfj
	L4MYI/EFV+nbd0l3lkQFHSBL1vfeUA2d7CurechHaLSCOoxd1tl5GcfXOectDkjsius3kA
	UxelJVsEw0P7r3wX2PD6X1xZSy50kDE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-OjCn0d4DMSyV_sAqbOcl5A-1; Sat, 06 Sep 2025 22:23:43 -0400
X-MC-Unique: OjCn0d4DMSyV_sAqbOcl5A-1
X-Mimecast-MFC-AGG-ID: OjCn0d4DMSyV_sAqbOcl5A_1757211823
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5f9673e56so26549041cf.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 06 Sep 2025 19:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757211823; x=1757816623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eKta5jItXUnhLWu5FlkjEeVXw/iB1AnfiY60QC5jWSY=;
        b=JuWJ6D4ZnXPlhvyY1S9ThUlHZdO4H8HKJDATHgE8xh/9zwvU/gliB0Mv/OTTWm6/CZ
         B+oaEnjbwYnTSbfzl389Of6HvbwZ0ye5bf4XHKxvwV/G/sQ3ezBgm6jS/AgAVuAsdduf
         zgb/+i9Bvire3RwbV2VyxiWJ8zGl76lu0KIKTTKlam1p6AL3xA3tRL3vytWUvB6omgXV
         GHZrRLrWEEc1zX57v9E0NGb+6vngfzfXyzVbGbMdubeuHfU2VJn0DB9dMLvnMRrwzzhl
         svb8YlQnG+E1chfbi5oAW52PR61U7rYDvdHehZ++1KoUPT/0JGTfOLXS+tcsFOASRRkA
         zEwg==
X-Gm-Message-State: AOJu0YzsFQ8NwkbNBfDN++nwGLja9DViowQtxs8eYLlF0Eb2+0I5ngiy
	0fNE+wwnlzFRUI2sbIT5ayzVZgphu3VxGJokfA8QM7o+8o7183q9h7/Hl1NSVMBt2YJCFaxUffs
	3tIZi81+MEzl/rlDjLkulPVf3/+H0rPqEEIBVYFO7RWFAo2bdC5u/YmBs/mv+/TlHIGOabyhH5Q
	==
X-Gm-Gg: ASbGncv0YJ7J1w/cbjA+WxX/ld56wS7HqP+cvpxgrRzsTwyHzmwAj+Du+W58Q2v3K/s
	lFU0DndR0GsMoXzCFx/9EToo3rXYCHCnKHnME9LLmZBGs+//IFWnNMTHUkQNMNRqxV3Q7kb25OI
	GpcV8dIYf6jFPz4W2X2WvbMOgz+hAolMFtGMLTYQ5LDhA7nvrLeUBaKF7n//tl85mEWyRv5NwHU
	8tNw9Pq7AOLE25vhGCuJjmJukmaeREN7dmP/Qs9sYOeV/LopYxkKMJCyiasx5B6vVWpztpi+v9/
	papHCb7o5CoO3jm6Ztesld8/m+f1tZ2BDHMjdlicYHrpmu7q7+MDhTJ4ADXwXBeuBRWxb0Q=
X-Received: by 2002:a05:622a:578c:b0:4b2:d501:d177 with SMTP id d75a77b69052e-4b600f9da7amr14115581cf.3.1757211822989;
        Sat, 06 Sep 2025 19:23:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmtY5i5gLC3Dh3QaLX1boI5IUHrEiKcvtJTsX24PLUziZv/6PXd9JR/FrcOLTBJP1OjMKzmg==
X-Received: by 2002:a05:622a:578c:b0:4b2:d501:d177 with SMTP id d75a77b69052e-4b600f9da7amr14115521cf.3.1757211822649;
        Sat, 06 Sep 2025 19:23:42 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f673fecsm71105401cf.21.2025.09.06.19.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 19:23:42 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v2 0/7] tools/rtla: Code consolidation and osnoise actions
Date: Sat,  6 Sep 2025 21:23:18 -0500
Message-ID: <20250907022325.243930-1-crwood@redhat.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FAi2oQZjklc-TkJBg2OsKxW3rcsko6a5zbHTzFf0Dug_1757211823
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Consolidate code between osnoise/timerlat and top/hist for easier
maintenance and less future divergence.

As a consequence, actions work on osnoise as well as timerlat, so
expose it to the user, document it, and test it.

v2: minor changes from Tomas's feedback

v1: https://lore.kernel.org/linux-trace-kernel/20250821035719.137161-1-crwood@redhat.com/T/#t

Costa Shulyupin (1):
  tools/rtla: Consolidate common parameters into shared structure

Crystal Wood (6):
  tools/rtla: Move top/hist params into common struct
  tools/rtla: Create common_apply_config()
  tools/rtla: Consolidate code between osnoise/timerlat and hist/top
  tools/rtla: Fix -A option name in test comment
  tools/rtla: Add test engine support for unexpected output
  tools/rtla: Add remaining support for osnoise actions

 Documentation/tools/rtla/common_options.rst   |  61 ++
 .../tools/rtla/common_osnoise_options.rst     |   8 +
 .../tools/rtla/common_timerlat_options.rst    |  74 +-
 Documentation/tools/rtla/rtla-hwnoise.rst     |   2 +
 .../tools/rtla/rtla-osnoise-hist.rst          |   2 +
 Documentation/tools/rtla/rtla-osnoise-top.rst |   2 +
 .../tools/rtla/rtla-timerlat-hist.rst         |   2 +
 .../tools/rtla/rtla-timerlat-top.rst          |   2 +
 tools/tracing/rtla/src/Build                  |   1 +
 tools/tracing/rtla/src/actions.c              |   8 +-
 tools/tracing/rtla/src/actions.h              |   2 +-
 tools/tracing/rtla/src/common.c               | 344 ++++++++++
 tools/tracing/rtla/src/common.h               | 154 +++++
 tools/tracing/rtla/src/osnoise.c              | 101 ++-
 tools/tracing/rtla/src/osnoise.h              | 114 +---
 tools/tracing/rtla/src/osnoise_hist.c         | 369 ++++------
 tools/tracing/rtla/src/osnoise_top.c          | 303 +++------
 tools/tracing/rtla/src/timerlat.c             | 210 ++++--
 tools/tracing/rtla/src/timerlat.h             |  55 +-
 tools/tracing/rtla/src/timerlat_bpf.c         |  22 +-
 tools/tracing/rtla/src/timerlat_hist.c        | 642 +++++-------------
 tools/tracing/rtla/src/timerlat_top.c         | 568 ++++------------
 tools/tracing/rtla/src/trace.h                |   3 -
 tools/tracing/rtla/tests/engine.sh            |  26 +-
 tools/tracing/rtla/tests/osnoise.t            |  27 +-
 tools/tracing/rtla/tests/timerlat.t           |   4 +-
 26 files changed, 1395 insertions(+), 1711 deletions(-)
 create mode 100644 tools/tracing/rtla/src/common.c
 create mode 100644 tools/tracing/rtla/src/common.h

-- 
2.48.1

