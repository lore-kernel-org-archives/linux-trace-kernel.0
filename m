Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793224897;
	b=VLiHGxA2QIYIRLDFdxpsDG9qHcFOUmMQe3OsOy76Qhp6Asj5iVxOl0kIowzuzOHU737n
	 sGyVyGDaTPhz00xopcXXq7IIvP/vKMLQU/Rqa0Nq5SeLAtoLP9FZjgtWrWHLlnxssQqah
	 M8CRfLQHSEnPTdS+yFOfYPFDwtpXncmMFrXoFk55n4EHK7j7DFew0gcaxxOoHDqFmC/Og
	 ei5SdgZ39yF7CQ0QetWAa2DdoGGVu6nqmkXbvTZGQ13YMjSC43bgAV0+y+6VsLa+AbX0r
	 i5mz2bIQaK0WUFtxhMTkiyT8Avh1Y6/SmvAHpjoZ+3Uvvi6NCPz3EFoVT+ZcBBpdzWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224897;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type;
	bh=gQ1ipSBqcBpEoEii3+fEn2tn+k95c15lcLwg2ncVKiw=;
	b=R8yJyAxOs0UhwkcgHKzMsN/lcRA8Ny/TxRXqciCVr19QkLEVF7ak2h6aoDgPsHmyL2KG
	 gd+1KMO0bPJCEKriybs61ItIY4es5tDTAWw+B8+WayH8ZSUqsFvmY18xe/7z7cG10EG/W
	 A144niThh1RK5U1XvCL4keCbthALKbX/Fxv60TKQQTWU4KSlghGsyo4IHWp7nuoKT6CJF
	 /g9UOZebFhvmzGkg9GrPBfh6q0IZoQN1zRjhCXGgnTJ1CUjOieiLMAYF00WjWJJVaqtos
	 5g0GE3RnrC7tvUWwSPZPsvPGEhi5F7JOGxEvAq9Z6voy0avKMIQ7dDj62HrY8QKX8PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dq1Rzg2J;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8121D606A322
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 22:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8121D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dq1Rzg2J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793224895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gQ1ipSBqcBpEoEii3+fEn2tn+k95c15lcLwg2ncVKiw=;
	b=dq1Rzg2JtqcU0vT3JTLopCzKN3gjfbFTp9ZAu+HAxjYFk+shJUgffsOIwgatTlLfWnFjDy
	jAQLkIUD5Ourq3tiHa0B86SXPMC/JeE/0K0Mm05hISjjSmEIkbHeLDinxXPEBJeDE/d6hb
	HNw2SZZVimZddNna4wzKcRmbYXEzjs8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-ASpAIOqpND-mNLqLuX6Ijg-1; Wed, 28 Oct 2026 18:01:28 -0400
X-MC-Unique: ASpAIOqpND-mNLqLuX6Ijg-1
X-Mimecast-MFC-AGG-ID: ASpAIOqpND-mNLqLuX6Ijg_1793224887
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-533928ef33aso23330981cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 15:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793224887; x=1793829687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gQ1ipSBqcBpEoEii3+fEn2tn+k95c15lcLwg2ncVKiw=;
        b=sN/i1JyrijX9UXTPXWgHe904jOkNMT8LzUJl4c9vF3808NYSqazAwIL/As6E2zdHL3
         oU8vSDGGEdcNNldS2xp1jioEo9oP4ZgTTbaFKBYJWxswwyAuvAHpw6eKYNilPMU2ACXc
         CQ7aI8a+J/4QXPs46/fN0Kui2BbUrf6sVWQ4NDELEAXsRF5Tj46f55TNx+iu+L5oFwjo
         Hg0aWYDUaj3GNU0XbPTZnO/ZrFKK/Fx/o2QKNcgoEStI4RO+F6YQzlhAUhfLa1nB3BEW
         OCswFixPR6wLLIDkT8GeTACSyq6Pyf104zD/iJ7nR5aHW/bfzthtjZzwn2dWKuD4w44z
         aPXA==
X-Forwarded-Encrypted: i=1; AKwUvBxZWYCA4z5SsD52J4wMFw3zWjWFB+0+2zOxslKZD9kKNUCUgNMvVoiGDwdPhfCQEfQ68DuAEUjFodWPYk3VKdABWnE=@vger.kernel.org
X-Gm-Message-State: AFq9FYILO1BGIwxl7qxzWPRTpKyXzSwqcPRds9NrAMI6INCMGZUv06Vn
	d4M1mjVyJ04RZssJtiH6BJ6jVZ12f/nHTDSD73nsbxAEBSQrQs/Md6vJRZEzVoimMu9M0081VCH
	9Y43Z1QsGC/ltWf+QUGWAEpO1oNCt4Ys4nR+pgwcbRd/bZCYo5S/2xVcl/CJseGFh1SlHcLcg2V
	HJIwfaGw==
X-Gm-Gg: AYBFou18zfPqbnigEZBOPLLjQkD60/E0CFsZgaNI7kHa2HpA43TtQV++itq103/Hc4+
	WMdM6gu9iPoZ2XUNJzwza/3UwcInl+wRBlDfRXkeYdLYCEW/PmWlW1ELQCNniOykIi6pQ6S7wVt
	QPhj/XU0nBlmb650sU9AJJPn2EYAvogSz0nmFuQS6hcW44sHVWv/yDmcIeC8+9Ug31gNUc+Gvu1
	DrM9nM7aqdMog96mgIhB9mjG//OsgsVRoLWfrWbq+UOk9iuYn5XoxeimTVQxouo5BDYboCAVoNh
	QDiAjnsNUTz6q9Kytu6oHglnNC+cVJMPXpvybB08n37G0LrfhocLtBc5JO0ip6szpYJfI2RrhzM
	jM4PfV+dF5lb+zXyHSVnUP1sZV4Nb9bh6w5/6ZDpdSGXpgfMr851Th9WplY9RwqlxH38cOr4HAD
	dofbdInbPdZioy6yTHQ0PHsdsSGgIk
X-Received: by 2002:ac8:5ac3:0:b0:533:3af3:43b9 with SMTP id d75a77b69052e-53fcbedb8f9mr65166051cf.44.1793224887267;
        Wed, 28 Oct 2026 15:01:27 -0700 (PDT)
X-Received: by 2002:ac8:5ac3:0:b0:533:3af3:43b9 with SMTP id d75a77b69052e-53fcbedb8f9mr65165381cf.44.1793224886703;
        Wed, 28 Oct 2026 15:01:26 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394f7e49sm114884001cf.15.2026.10.28.15.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:01:26 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v6 0/10] tracing/osnoise: Synchronization fixes
Date: Wed, 28 Oct 2026 17:01:10 -0500
Message-ID: <20261028220120.4005187-1-crwood@redhat.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fCeldCjntleJRUAmnJg5y-fCrFJzJA4U1c7i4_rvwdQ_1793224887
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Various improvements to synchronization in osnoise/timerlat.

v6:
 - Revived the "Always check OSN_WORKLOAD" and "Split out per-cpu
   variable resets" patches, with fixes, to address minor issues raised
   by Sashiko
 - Other minor Sashiko-requseted fixes

v5:
 - Removed "Split out per-cpu variable resets" due to Sashiko feedback
   about races with NMIs and other tracing hooks; the main motivation
   for that patch was problems with osn->sampling and tlat->thread,
   both of which are now explicitly cleared.

 - Fixed some patch shuffling bugs in fd detachment that were revealed
   by dropping the reset patch

 - Added "Start all eligible cpus from hotplug workfn"

 - Removed "Always check OSN_WORKLOAD" which is no longer needed after the
   hotplug workfn patch

https://lore.kernel.org/all/20261024015614.3095251-1-crwood@redhat.com/

v4: fixed a problem with the v3 fix spotted by Sashiko

https://lore.kernel.org/all/20261014220759.908839-1-crwood@redhat.com/

v3: make sure osn->sampling gets cleared on stop, even for non-workload
osnoise (reported by Sashiko)

https://lore.kernel.org/all/20261014022640.695786-1-crwood@redhat.com/

v2: addresses issues raised by Sashiko, as well as a few more problems
discovered in additional testing.

https://lore.kernel.org/all/20261010022338.2507589-1-crwood@redhat.com/

v1: https://lore.kernel.org/all/20260824211544.3984835-1-crwood@redhat.com/

Crystal Wood (10):
  tracing/osnoise: Variable cleanup
  tracing/osnoise: start_kthread: Always check OSN_WORKLOAD
  tracing/osnoise: Start all eligible cpus from hotplug workfn
  tracing/osnoise: Hold a ref on osn->kthread
  tracing/osnoise: Per-cpu mutexes and fd detachment
  tracing/osnoise: Split out per-cpu variable resets
  tracing/osnoise: kthreads: Verify CPU after migrate_disable()
  tracing/osnoise: Take trace_types_lock in timerlat_fd_open
  tracing/osnoise: Print taint message for timerlat
  tracing/osnoise: Refuse timerlat fd open if tracer inactive

 Documentation/trace/timerlat-tracer.rst |   5 +-
 kernel/trace/trace_osnoise.c            | 480 ++++++++++++++----------
 2 files changed, 287 insertions(+), 198 deletions(-)

-- 
2.54.0

