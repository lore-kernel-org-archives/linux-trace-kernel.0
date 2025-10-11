Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A02238C36
	for <linux-trace-kernel@vger.kernel.org>; Sat, 11 Oct 2025 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760171298; cv=none; b=iJRchCUvunaL2LaKNsPf0WAmzg9WPvIh7Aw/cBj4kN558f83GoZ6vV4k9GhM1QtNA5rAsV41hWR8YsWtObOWPu1sQWo3FZhL1RhKF7/z90VEmAqGY8eFs5lHyMOJrZ3anoLyu4f4eguXUomLL2VsA3qqUDB5mr+kQfQ0luIERvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760171298; c=relaxed/simple;
	bh=ibj9y3XGzitL7WUJYZHY4Uea+u+ouP63eobF+V6rTcQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=bh/QJlbnekb120Lho89PDzPuDxF5cWiNiGiCP1kf43e8zfUu865GJlwj/bV/BAxg8BO8Y/b6rvrbjN9oxo83wJnPVmsMvwTuByUkU/UfJbeyvdP1P29lrjFF33FfbXc+lj+P+lbQVyQDFynERPquTJYmPihbFaMWAxuaNIEktos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DLoAM0sP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLoAM0sP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760171292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wRWfEct05XF5GxNiOGHZpckrzzE7GqksRk3vN/AYVmg=;
	b=DLoAM0sPU6gQvs4lTrjPNEaZJ1WEMye6NgiLoIXF8kG3RVICpqjmxxltX2T04lN1efE/g0
	apbNdyQ9KAbwDzY+idvOXu25n0cigxQM5VC+/t3Z6IxQeTt089YWgPqZGc7+rjiZsRLNzi
	4KxM2PdX2/VUzET2QYkTxyHvZ2Emtx4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-_7OjZxCmNpaw9Elo4SQu_w-1; Sat, 11 Oct 2025 04:28:10 -0400
X-MC-Unique: _7OjZxCmNpaw9Elo4SQu_w-1
X-Mimecast-MFC-AGG-ID: _7OjZxCmNpaw9Elo4SQu_w_1760171289
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ece0fd841cso2291909f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760171289; x=1760776089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wRWfEct05XF5GxNiOGHZpckrzzE7GqksRk3vN/AYVmg=;
        b=BIm+yN1dLpXE1DGls9cckDAllAFdTxOFAYWWdlMcSEjhS6avHM5aJ64mB4W+K+eiCW
         qfbzDpkh/hK4YM3wz/jAgdHIrKQbFlufqKlx+W3FJcW/+tS6p0hpflnJSKU3NyjuLIhf
         8+g3HpTlP8SA+Z5dgxDW06tQZsmgeFRy7Xbbihwtcm+sxAKHTK8SX8aaPGCJL/01xGRk
         YlQo1v3VrDUSoJhxOT0m1DfVnmlKTtv0ojVlNCVR7dbUEhjMGI6pjfVCYnURZW7+JWTO
         zOgQFXs/VcPxbK0EdVLsP64CRSx12krtra9L+mD8kDIL9eISyqxZQa8KeC36RcmFrjiq
         C6SA==
X-Forwarded-Encrypted: i=1; AJvYcCX8ArhMvmCIHSYmL2BppCzQY86zNT9OOIJ8M18s1WNhhFE1OSj+5U0ApM7Axy4AYV0OZ55IcOoLsYAJq9CjP/R9tOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXBCkBLtVXOqU5vAFKEtC+sQMSmh2SDOkOJ/S9yvJh6nGvBAry
	+e4nQeH2jIBFpyRLFSLvGb4ozIa8+pSHzHfjRb1fHOaGxWlT1xXpsb7D786TsLnYRXE0h6GOUMd
	UKL6bKQxvAYAacdcqz+bUkchIfw6AQIy9VivDzvQvTRhetq5kHgm49Ex4NyEsT+VL+0xWRq9UZQ
	==
X-Gm-Gg: ASbGnct2orVbPRUmwUxZIJjTEwMcjI2Oo2I4VpLK03n9Js5gYsd/rmPJun9mu4ypifV
	mmkKkQ1F4ndhq0MCgvggxGfmY62a3B7AfCbbwPoSzeMsjLu6ClKSgAmppF1JQ2suTaCYUmDE5uj
	4eHw1o5PP6n6XuT4oYDuxBvU0iaw4cz/fc2qPPLX3GB1QrFKfd/fhqsr+wWUUSS9Hi+Fgcz6zLH
	YCcy0xRgJag3G19Kc488/Cp4p/Ra63tgUCZ/VGoy4Bwp9vMYJEXr0EflrafnjoHoJl3pD4a51s5
	4AEB2d0AJot3RpuVKRc0vEIlsLrOx06sk7abhLymStUr
X-Received: by 2002:a05:6000:40cc:b0:426:d5bf:aa1 with SMTP id ffacd0b85a97d-426d5bf0b37mr727820f8f.62.1760171289491;
        Sat, 11 Oct 2025 01:28:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv+HY+qfihGeK/GnTuDnWbsq9s+051t5h9Mrw/U56mNyFoV7aOb+J0sxA944NzQ+3xeannQg==
X-Received: by 2002:a05:6000:40cc:b0:426:d5bf:aa1 with SMTP id ffacd0b85a97d-426d5bf0b37mr727804f8f.62.1760171289143;
        Sat, 11 Oct 2025 01:28:09 -0700 (PDT)
Received: from localhost ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d0006sm8022580f8f.34.2025.10.11.01.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 01:28:08 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] tools/rtla: Improve argument processing
Date: Sat, 11 Oct 2025 11:27:33 +0300
Message-ID: <20251011082738.173670-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GxyOyKZnptAseP41C0zGlGNYGtuGlvuxPTT7MokeUqQ_1760171289
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The long-term goal of this patch series is to reduce code duplication
and unify argument display and parsing across all four tools.

Costa Shulyupin (5):
  tools/rtla: Add fatal() and replace error handling pattern
  tools/rtla: Replace timerlat_top_usage("...") with fatal("...")
  tools/rtla: Replace timerlat_hist_usage("...") with fatal("...")
  tools/rtla: Replace osnoise_top_usage("...") with fatal("...")
  tools/rtla: Replace osnoise_hist_usage("...") with fatal("...")

 tools/tracing/rtla/src/osnoise_hist.c  | 74 +++++++++--------------
 tools/tracing/rtla/src/osnoise_top.c   | 68 ++++++++-------------
 tools/tracing/rtla/src/timerlat_hist.c | 82 ++++++++++----------------
 tools/tracing/rtla/src/timerlat_top.c  | 76 +++++++++---------------
 tools/tracing/rtla/src/timerlat_u.c    | 12 ++--
 tools/tracing/rtla/src/utils.c         | 15 +++++
 tools/tracing/rtla/src/utils.h         |  1 +
 7 files changed, 128 insertions(+), 200 deletions(-)

-- 
2.51.0

