Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A000287260;
	Tue, 22 Jul 2025 22:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753224979; cv=none; b=nfc0LnFNIMNB0g0+CdK3kqHsDRoVF8nTsNCmoxoCChgalJ5DMHHYqmy6Etfn+lw1fm8dHVoBMLYJGTUnCw9qZCtR1pf+RHFuxTqXBlEclN7elTG3dNLOsmM9sJjaU7wMk07UhzhPMYaDxCcKWgi0jv7FmV/qpEatHZwwRcnnMhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753224979; c=relaxed/simple;
	bh=gNnQ1ATC0LNWz/PO6c/hPn5m51igMSNYoD56Er7ePB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M1uXoXEAHi2hdwNu72cYjDKm/VFoGN6EjTXHTY3JvRL/D3buCIJiBtt4y+PzT5XqHNR/BHOO3S33b53pWPXyeyz3kt2OymxTjL1hRq6h3Q4lE/eCYqs3VAgh5Ovx0RU9+uqR6M1cQxRkGFd3/b+7Olk8odIhGu0o4v8f780riu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/fHiLtB; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/fHiLtB"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ab644b8dc1so66069051cf.1;
        Tue, 22 Jul 2025 15:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753224975; x=1753829775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gNnQ1ATC0LNWz/PO6c/hPn5m51igMSNYoD56Er7ePB0=;
        b=Q/fHiLtBob9ECXXsd1Nt+lPU35StblMgdBHL/u04StZOA+3RZ9QqvcuB6eHVoUAG56
         Tv+iKkxv1yFXtjQALNBLcallWFmMCXIZRoAXMsYKgIQS3jKHDXOQ4a79ty+4SFC8Brn/
         avFBavt+QNHgregd/qibWc7TrJl5dN8Zz5ZJoGDVPam7YXFQH54pvSje48+rRGrdtEL0
         ORW1rXgqjm9je8oabCjJ7wqvS+OHnrBS3+HYww7znxxCAwBQ6Y1Mpfa3Ic9yT9Gc1C6S
         JSeg10EHkytrqLBg6JsIUBOT1MEP1x7Oa40LR7zYmXHP2BbYMIP6P5bg3iQiiH7StMEC
         9C2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753224975; x=1753829775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gNnQ1ATC0LNWz/PO6c/hPn5m51igMSNYoD56Er7ePB0=;
        b=A+pv5aHti2P5+qw2bSNdWzcKq8zrJd0u4h8ffunqGKjBDfwkqxnKw0Otn4zU6IwVZX
         Vr1xXqKiX2bdZYVLNWdwf3q54t9LU3Tp4mGV77AVkgi97OULu1Zk8Il+gsJsn25/P/Az
         +0Qn4PnU1QLHwjSX0LFGj0d77T/DA0DND/mP+zJmg76WYc/1jPllSRuq02ObeEPqcyH1
         607eB9NJGW7VOcXZwovbGRFe0nJRaeNFdPNbqPg/btK1oUIcYNQaZvKTCXjW7t2tKv1e
         SH3SJFL7SjQqoaydVr2VKW6y89vKb+JskKKka/Y8GgOYubFfXqtGz93uw+aeLjXpVRaT
         +bxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk0yC9HYChrbK+ol4y32/JsJ9s9Bu32IdLqYUuL2wmnQdRMuhjMQ7xUoGZcW2G2CVfqoccy+D7ITupF6E=@vger.kernel.org, AJvYcCWUoFy1vwxuz+AyDsHMd9zyEHwiSQ8FktH9/DtDnXmhPm4+OSNHumvAgmyt13uVqsnKk5bh/gefMiFXQlukIBxKMxvN@vger.kernel.org
X-Gm-Message-State: AOJu0YzEg6UhJAvResBi2w+kZlRfQY2PWutH/4UYCzUmgyxZ7LHten1x
	dq09aU04nQmUtkMMwSiwNY/17JZNEgk4Ek67RXVE93CqNZdr+berszuF
X-Gm-Gg: ASbGnculSHdIb9O8AviNlcOcRkiRyVz2p4gNikbid0x2JHsq6+J50V0BW0hNfajNvnn
	+ejmEACgHGJcvKFxuaT0AaRqYoDMXT/6dQ9n4I+oXMigvbPYeAf7RmUkwfCqw7Nx2Wxc4NcCfhy
	naMjRNvuWIB+oF5gVlbKX6LITGlnzosfXf/IF5z4fodIF5CPfVKgZquhnvXTUdkYOt8I51KN4+d
	alwNNuYmLbNqW5AF+Ms65bF7RiLrLth080m5zskuaIWRu2n516/wjI8CtqdX7xBi9e16wm+jjZZ
	muxDSxDeiLjHmd6iqRE/5ZMFmlSYiFGZBP8aPZ1GQTtsF1liqdtXy7A3w9J36xlLy17nrJL4Dd9
	CPxq5xadscT75qgtYEBZI66mY904pxvSMZqbLCuSdiA==
X-Google-Smtp-Source: AGHT+IGdtjTqUjhEz+qfyyJ+EWxXpOukye+UPJUMV4qHgq7s5J6B0IZ7q049Z30GCAoVqvuIyz5mFg==
X-Received: by 2002:a05:622a:1818:b0:4a9:ace0:b24e with SMTP id d75a77b69052e-4ae6df7643emr11579601cf.37.1753224975382;
        Tue, 22 Jul 2025 15:56:15 -0700 (PDT)
Received: from Gentoo.localdomain ([37.19.198.68])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b4a544sm58875901cf.70.2025.07.22.15.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 15:56:14 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] tools:bootconfig:scripts This file was missing the shebang line, so added it
Date: Wed, 23 Jul 2025 04:23:01 +0530
Message-ID: <20250722225351.8811-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This file was missing the shebang line, so added it.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 tools/bootconfig/scripts/ftrace.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bootconfig/scripts/ftrace.sh b/tools/bootconfig/scripts/ftrace.sh
index 186eed923041..cc5250c64699 100644
--- a/tools/bootconfig/scripts/ftrace.sh
+++ b/tools/bootconfig/scripts/ftrace.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-only

 clear_trace() { # reset trace output
--
2.49.1

