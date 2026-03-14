Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F7F386566
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 20:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519307; cv=none; b=lKn4s4XG6ZgjhQv8lMbp9xzy/8BmPMAquOaU+EE5YKPHmiM1iyy8JAhRTCbGzfbCk+74WTaZjJ6KR1vKFnHdJUE89F+lzPNSleGLhPN7EXPUz+NOUWFY5C0SRonZG6YTDnBhzT9o5okebjtfZ7m/QZoJCBPbOA0/AEmpjABv1yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519307; c=relaxed/simple;
	bh=cj/seZubwP7nLqBoz8ofrtucQHhr4mn40yQgMXMr40Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMCPSpZ4PAAiGZJTpRGXjIVnylltOcOXcfT1mSlc7U/QcPytbH4lJ2klGt3Xe9NrlWKmYJvaNPPDwvYorA92Jp9VlGE8cYv8XpRQcM5MSTgGcSwq6pvinlHKKcgQ3D/MBQcja6uRMNo4Lv7SEapbeWA16J7iZcJdBZ3nHyZ9QPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivkAmQmz; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivkAmQmz"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-41729dc7d7aso1272392fac.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 13:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519304; x=1774124104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ib/vlu986mcpuvwIbmamafwqas870ti4JrE+4bqQJAA=;
        b=ivkAmQmzdcLJlNNYxp6d5Wvnrm5CvFJdBD52nglEHtaE7RwLh47ZMzL/ttonOB+vJW
         ZQDGv1lXXvYBjtu1ENydtWMCaC2R2fQ7ha+kdZFhUuOrMKfz9QO4ITE9pa5Zvew7Bx/V
         3dtfMLqZ1vEpFcQSBZvLiFGoB/FTq8slitueAr/d1F4HZw+eKO9/iLaEHzdp882Ss+hS
         C6EjZrO/iSi7raWOMd5nLDoooPqMIEwpIYFA6dRACEEYxrdCceevaNy2bx3fyx8kMWBx
         7JOOU4OtRct6dgB5K6pv4voVVEYlyEHiMgrIh35dTNf9rDrwFhxld1VAse/CgIwdmcfj
         ifjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519304; x=1774124104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ib/vlu986mcpuvwIbmamafwqas870ti4JrE+4bqQJAA=;
        b=JQsslOtqanSdwyqAxFhqeknY6dkLXxy6RXKwBTsgdgbUeRC2T85yIHlZXZYfKNzLQk
         W2mpvATxF4UKE+1XajTkbQ5j8sbYr/qv8x6n/1hdPdmTXiKFFed1WL5rtb7ZLBcdcUxs
         U9bM2AA+9R0yafmTOMe5wtChiMnDydoos46AGxbi3VacT5YhJPEwLPzNvozjVLvj1Hni
         3lmGCg18Veyc96PiAgRllc1CwUHX0UY3DxinCbgrboFDzQgXMq36KxmVMkF0mQC5/ChV
         npEdHc1T424xOCclmYu9B2oBo6pUIXep9YhBi7JN2adCIxx1FJ64maiAah7LprXf2fEu
         zkUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrBskOV4r0txLcwQYBE7vztLPI5Q5VQEDreMZBnCc4ra/8rSAuPbP7Xv1QN4EEb1fFDJZtEQreHNL+IAV3Y2eeNSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM5SP23A3OR6pNN6iy2ht/P4vW7JIvcrmt9Ll0GxKUL7AmEpMZ
	/NlWn50prUiokYBYnuW94LDSvcNP8LxYAbtp7UBWui9/atgL1QDZkcXw
X-Gm-Gg: ATEYQzzQBB+uWh5ZGL+ldP+T/L8+CFimDrvlOqT14aDyo6EuWuu0EoiJoHPEahZpc6v
	shj0fs1qYq0S3euDxLK1WJ5lRxlUt2CVU6Xo4xPvq9B648v40kyZvCA9P6rdL1+t6yd/VJWXCpm
	tCvLuqck2XnAkav9JCuxj7pH1VGPMMqPkGeujVuq2STxLzpHJ0VpT9LJyYuHYKkaYxCE03I5LGd
	x20JSiRRjX2PsPMP/aULwoPevLjku+rDcyEgKzzyp4XIc3ZZ2+WBYhJXdL1GhhpVgM+9y4KgoCz
	zWlSkEA1314VBUe+djRCXsz3O4daSqCAusGxjTszrlwSNn2n7IciTqPfMmabkvZtCGLgslQ75PM
	UklqiTtvI1B2lRgsaiFc9RPXL37GQz5fmdvZOn+CAKvixo4mBTxfZEYdB5jMdGKQL+IbzHqazc3
	dXj6Ow2hS01iowCR3jsakjeemfVukkCoA560GvGalgi6oVhIdLdYn+pH53fgy0vG3exDGRA0G+U
	0r5vByc6Fq+O44SgNlT6WEJNB6I6cKoedMjMV+U
X-Received: by 2002:a05:6871:c949:b0:404:168:3ba1 with SMTP id 586e51a60fabf-417b91d86f7mr5008979fac.18.1773519304503;
        Sat, 14 Mar 2026 13:15:04 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:15:04 -0700 (PDT)
From: atwellwea@gmail.com
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	dsahern@kernel.org,
	horms@kernel.org,
	kuniyu@google.com,
	andrew+netdev@lunn.ch,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	skhan@linuxfoundation.org,
	corbet@lwn.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com
Subject: [PATCH net-next v2 14/14] netdevsim: release pinned PSP ext on drop paths
Date: Sat, 14 Mar 2026 14:13:48 -0600
Message-ID: <20260314201348.1786972-15-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314201348.1786972-1-atwellwea@gmail.com>
References: <20260314201348.1786972-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wesley Atwell <atwellwea@gmail.com>

nsim_do_psp() can leave an extra extension reference pinned until
nsim_psp_handle_ext() reattaches it to a forwarded skb.

Route the drop paths through a common helper and release that extra
reference when __dev_forward_skb() fails and when start_xmit() drops the
skb before it reaches the peer RX path.

This is separate from the peer RX truesize test hook itself.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 drivers/net/netdevsim/netdev.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 22238df79b6a..c22513c523d6 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -187,6 +187,15 @@ static int nsim_napi_rx(struct net_device *tx_dev, struct net_device *rx_dev,
 	return NET_RX_SUCCESS;
 }
 
+/* nsim_do_psp() pins an extra extension ref until nsim_psp_handle_ext()
+ * reattaches it to a forwarded skb.
+ */
+static void nsim_psp_ext_put(struct skb_ext *psp_ext)
+{
+	if (psp_ext)
+		__skb_ext_put(psp_ext);
+}
+
 static int nsim_forward_skb(struct net_device *tx_dev,
 			    struct net_device *rx_dev,
 			    struct sk_buff *skb,
@@ -196,8 +205,10 @@ static int nsim_forward_skb(struct net_device *tx_dev,
 	int ret;
 
 	ret = __dev_forward_skb(rx_dev, skb);
-	if (ret)
+	if (ret) {
+		nsim_psp_ext_put(psp_ext);
 		return ret;
+	}
 
 	nsim_psp_handle_ext(skb, psp_ext);
 
@@ -278,11 +289,8 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		 * the synthetic cost; sender-side skb accounting stays put.
 		 */
 		nskb = skb_clone(skb, GFP_ATOMIC);
-		if (!nskb) {
-			if (psp_ext)
-				__skb_ext_put(psp_ext);
+		if (!nskb)
 			goto out_drop_free;
-		}
 
 		consume_skb(skb);
 		skb = nskb;
@@ -303,6 +311,7 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 out_drop_any:
 	dr = SKB_DROP_REASON_NOT_SPECIFIED;
 out_drop_free:
+	nsim_psp_ext_put(psp_ext);
 	kfree_skb_reason(skb, dr);
 out_drop_cnt:
 	rcu_read_unlock();
-- 
2.43.0

