Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6475239526F
	for <linux-trace-kernel@vger.kernel.org>; Sat,  9 May 2026 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778337057; cv=none; b=Mh4yorfvWyVRg/Q/rEe2lYGxZe70TZM1S46bvK1c/cVJ53uSO131VafutgcGDYBSwl+it2p3Wvilj/LufKwPcV1gVlQty2I4U2nQdUr12frnbdbDPbGglEUFs3Z9K35T0y+QQNiXH1QX4U3nI1VHdWNxKvsnNHKRyQj67yYLJX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778337057; c=relaxed/simple;
	bh=6C9t7mvLqJfxIdsk1XSEzgDDg6fGZGpJmzji3OPwvLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+51iSK1G9XBFcTgkBWp4F6bSnrsyzJXOYrBYnqPTMv2HkNwb1MKsaLL5dc/CfSU0YToXJMaWp7QQepKXHek66ew07dmptGVFLx2bfegvmiaRtW+Ybm/r87RUu1fjRM7egoETalmFjEtrtrqb/K3Y93ela7lZDoV88aYVgqps9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=smqSW/wx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smqSW/wx"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso20350305e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 09 May 2026 07:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778337054; x=1778941854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xCmQVKLqRiICM0wl4m0nAkVH1pHoZdM7w1jihSXzkk=;
        b=smqSW/wxlM0Sav59f8a77AT9cDgR7YJKLoyO3KUpEbL5NF8HBJsainE2DVejOmjwcy
         ZIdPk5Di+0+mQnJ6uZMRf8Tiy16nLppPuhnS3Ewjwzg05Wxa3yebJzG0ONoNEZmqpF6D
         CS7sAvSSm0oTTWx+Z3tefMGbMHliz/YsHJVqEi4MfXdVwOZg6fVaIyT6WLPTPKdJaSo9
         qzFK4S84kmbiafx3JaQxzqXcj7BaqAJi3p08pwT1yh3Kc1+mtiCoY+OFn7b8A1M9IhpM
         m/phXSf4BWROiOBtejpRG164IYbVSo43ToiywqKY+9hUyO/SB06VVRKOHoYmLmAc454G
         dxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778337054; x=1778941854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3xCmQVKLqRiICM0wl4m0nAkVH1pHoZdM7w1jihSXzkk=;
        b=N996Bb57b1cdoOXgHXZkMVxYyEN6glyWipeYMfIf26Y1xQffvS8L3sYtf7wTUL6Ahm
         9iSQaxEzQCFO00s4s3xDGYhgu6RoUJWvrJcxyCcosKcHI026jQWRUAARcagJkP4d3xOK
         vaNfwEPoqCVF5IMzOKcunCkTdi6tvB7BewnVbiV1zdVuGkCh0CMiPNvAKvJpQC4e36h9
         TmWdLGTnqgv5FhM6Wa0/tKUm7k10tNRIxxykS9MkPprZzzY+S6oPhxCk/P5i/M1NJfav
         KFx3I5dB5qvjSkM1EHYtXMXfzJJtVt9Aq1RcAWcNTF2rEEORLwPLUeyIzY73w1fNdTET
         QPsg==
X-Forwarded-Encrypted: i=1; AFNElJ+acB5s18UhbPxksnV7BwwCBqSZpKiX5Q3LC6sdDSxDaMg6SBfeAVaBfvEExdvP6+exZ2Ts5l+UdQW+hPXF8TsIiaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEOKieyXrr6jL2WkFEntp7Qbu0sB4YH0QEnXOJSk1cNA5rq+fu
	xx0kNl4+l+9pU7hl2jaNJYCxoMw5HS2Oz8bhEEX2jr+hOoR6L1AjrbeT
X-Gm-Gg: Acq92OHtQOGcUv0c8T1uWh7bGOypnDEaW4cDlM5ZbYtVGa7TGAii9z9QOcrOmXmr1Cm
	7fmlzmIDgc+MCc37XoE8TJoEDNxjpgi3APlBGaQFWArmvKT5eEhfb45/KY6LWKVWYgaiNDlyAc4
	soiYhIxAby/6zlQobfsSkH3TTfVvPuysMFrCx8HguBWBsD8ssVPfEhkW151iqUgE3t99ziwlosA
	k/GRCNa9QYtpW/jbyH9pDC+ePLhxQhRkdf/joefIFi8msKKk7iFMb4Ji3gPOE6eNZhy/nv93ELJ
	qio4hZn999PqqU3H2lFXX4BTIhPQwq4H71vfCEI/aO3/GaN2LAMlnledX5BtMEl48F7IfKB7LWm
	8vb2qV20WpC63bYuB9xYMKHg0RsbBVEspAXThOrnlT0MBnk8OzrJN4BBL9aOJ2NWnaVfRWfq8L8
	s2nza6rwyhgu3ppjC8NJ72SHY3F1O8HwEcsnCP2PC96EbFK+4U0gdq5BIUzE0WXR9W9LK3IC2US
	Tq1Gg==
X-Received: by 2002:a05:600c:524e:b0:489:1d74:56d with SMTP id 5b1f17b1804b1-48e676c14b9mr106487865e9.29.1778337053396;
        Sat, 09 May 2026 07:30:53 -0700 (PDT)
Received: from arey-arch ([2a02:1210:7298:ec00:73f0:d2e7:188c:1f61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702e5614sm55015505e9.9.2026.05.09.07.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 07:30:52 -0700 (PDT)
From: Adrien Reynard <reynard.adrien.08@gmail.com>
To: paulmck@kernel.org,
	corbet@lwn.net,
	gregkh@linuxfoundation.org,
	dhowells@redhat.com,
	mhiramat@kernel.org
Cc: frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun@kernel.org,
	urezki@gmail.com,
	rostedt@goodmis.org,
	skhan@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	pc@manguebit.org,
	rcu@vger.kernel.org,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adrien Reynard <reynard.adrien.08@gmail.com>
Subject: [PATCH v2 2/4] docs: fix repeated word 'that' across documentation
Date: Sat,  9 May 2026 16:30:50 +0200
Message-ID: <20260509143050.16458-1-reynard.adrien.08@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508163759.16231-1-reynard.adrien.08@gmail.com>
References: <20260508163759.16231-1-reynard.adrien.08@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicated word 'that' found in RCU/rcu.rst,
driver-api/driver-model/overview.rst,
filesystems/netfs_library.rst, trace/histogram-design.rst
and trace/histogram.rst.

Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
---
 Documentation/RCU/rcu.rst                          | 2 +-
 Documentation/driver-api/driver-model/overview.rst | 2 +-
 Documentation/filesystems/netfs_library.rst        | 2 +-
 Documentation/trace/histogram-design.rst           | 2 +-
 Documentation/trace/histogram.rst                  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
index bf6617b330a7..110f3d42cace 100644
--- a/Documentation/RCU/rcu.rst
+++ b/Documentation/RCU/rcu.rst
@@ -32,7 +32,7 @@ Frequently Asked Questions
   Just as with spinlocks, RCU readers are not permitted to
   block, switch to user-mode execution, or enter the idle loop.
   Therefore, as soon as a CPU is seen passing through any of these
-  three states, we know that that CPU has exited any previous RCU
+  three states, we know that the CPU has exited any previous RCU
   read-side critical sections.  So, if we remove an item from a
   linked list, and then wait until all CPUs have switched context,
   executed in user mode, or executed in the idle loop, we can
diff --git a/Documentation/driver-api/driver-model/overview.rst b/Documentation/driver-api/driver-model/overview.rst
index b3f447bf9f07..4360cd5200be 100644
--- a/Documentation/driver-api/driver-model/overview.rst
+++ b/Documentation/driver-api/driver-model/overview.rst
@@ -55,7 +55,7 @@ struct pci_dev now looks like this::
 Note first that the struct device dev within the struct pci_dev is
 statically allocated. This means only one allocation on device discovery.
 
-Note also that that struct device dev is not necessarily defined at the
+Note also that the struct device dev is not necessarily defined at the
 front of the pci_dev structure.  This is to make people think about what
 they're doing when switching between the bus driver and the global driver,
 and to discourage meaningless and incorrect casts between the two.
diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index ddd799df6ce3..715218e1b233 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -626,7 +626,7 @@ A number of members are available for access/use by the filesystem:
 
    These are set by the filesystem or the cache in ->prepare_read() or
    ->prepare_write() for each subrequest to indicate the maximum number of
-   bytes and, optionally, the maximum number of segments (if not 0) that that
+   bytes and, optionally, the maximum number of segments (if not 0) that the
    subrequest can support.
 
  * ``submit_extendable_to``
diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
index e92f56ebd0b5..c25587f411f2 100644
--- a/Documentation/trace/histogram-design.rst
+++ b/Documentation/trace/histogram-design.rst
@@ -738,7 +738,7 @@ creates its own variable, wakeup_lat, but nothing yet uses it::
 
 Looking at the sched_waking 'hist_debug' output, in addition to the
 normal key and value hist_fields, in the val fields section we see a
-field with the HIST_FIELD_FL_VAR flag, which indicates that that field
+field with the HIST_FIELD_FL_VAR flag, which indicates that the field
 represents a variable.  Note that in addition to the variable name,
 contained in the var.name field, it includes the var.idx, which is the
 index into the tracing_map_elt.vars[] array of the actual variable
diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 340bcb5099e7..ca619499ce28 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1700,7 +1700,7 @@ to that rule is that any variable used in an expression is essentially
 'read-once' - once it's used by an expression in a subsequent event,
 it's reset to its 'unset' state, which means it can't be used again
 unless it's set again.  This ensures not only that an event doesn't
-use an uninitialized variable in a calculation, but that that variable
+use an uninitialized variable in a calculation, but that the variable
 is used only once and not for any unrelated subsequent match.
 
 The basic syntax for saving a variable is to simply prefix a unique
-- 
2.54.0

