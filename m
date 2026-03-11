Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1243BC677
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215804; cv=none; b=fVG9EtggDbxUciEBiyz6HSBlAiT+iUEKTalKCFMFFl1TqE4Yh+V8RtjTQidYO9TBz/ECIbgygzBpTx4JJioGSiFmmZi30yABh6gPSOEEf8rgCtTuphPi6q71QUU6cfRSY1amjvczfdPor5IB0BvIOyL5sqgDSlDrPI3Ts3Ibex4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215804; c=relaxed/simple;
	bh=9YrqMac2RvVbcQMvhIkvAs6CdxSyWCSfXy/rvRlKfmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eGAgnhuFyZ7NYQVUSKJ5bmW+Wat/oCIfwEonT71uUACXycQ6AZiIiUiaRtE0h75zq+ShJBsh+t+PWreDPTYOin7PP93GsIE9k8i0miV0CfdFr6BAKgSUCiIa5B6tgEooAPZUE5bTk7A5GDao2DU0YlRx0seujEiP/tEsevVMxZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bf4OdtH7; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bf4OdtH7"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-40efc77933fso5703288fac.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 00:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773215797; x=1773820597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQ1OrwVz8Z3OJFcYGZCm4ACsYMr8Af3yv6w/TQO392I=;
        b=bf4OdtH7dYvZH0Pm5BCE0v6Kyxgrqcm9ifR02nbDzdUgjo4ncoo7rOA6dUpoXbNOjl
         Cf18YTTMviUOYlpP6pO4GkC9utn3BDvSRM18341vKYC+if5y93YQ89ulI/GZlVhEIB6I
         3RamUOhKpNPdZSdRSvU2vlG8WmcwO1I7w5cF6qDNtfbNMdWux7C4uOrzuWX9CE0Ms6oz
         EsIgclWrrW399y8mn/r12uYJRC4B+2LkZRW3YmZs+B6OvsmEDFFOHblSC1kG0ETkG/AU
         BzCvlhugDNX1fI/4IROI5CgS3sv3hosqE80Lk9ZkPMPB/Uo1ROn16Qfz4CiMFrDCA2k+
         BAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215797; x=1773820597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DQ1OrwVz8Z3OJFcYGZCm4ACsYMr8Af3yv6w/TQO392I=;
        b=sIdhsx5ChM0aKTq2/6pT+uas29NSuMQWS7W8EkuNEAqj+mAXCl4LHD5sQYhBOsctUA
         AY23UrU+CTS7lmoE0CkFKDDYn3sSCdbrb67uU4TRvjPk/xC289n0O75LBy6wYNJEbiNH
         rvNB+oZNRfVL2DoEY72+iugDxYQw6y/6ZS7Q6/G4xlvEyVelMoH4BSfZ4AqiDhNHMomj
         V0xeK8pMXYHyFIs0ezzSKf/CX5laknZvpVcQzYB5Cf0T/zjG+YVRb6F/b6SMbBskd1Ym
         4sjjlSxaz1/KTy/9zKEwG5fLeKLjnLpLgMePRee/FE7Coyo7ioMpNj3/McXuaBfd3Azj
         7lww==
X-Forwarded-Encrypted: i=1; AJvYcCWlZc07d5j9cTDfHbtJPNEJelGeeDVRgSNmjHREdQN6cThdFnG2qbr0ro1e6YfDpKcw6scksHvD1/aLAHYcga8319M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQy5CprQr3E0eTdNjYkROi089TF0GG7u0T58QKJ6TX6Ya+AFVE
	+N50wYAInS/H+R5Z+0htQkD4j3/+kRr2Hz0Kr/UJGNEDZMwQh1KX8uG2
X-Gm-Gg: ATEYQzy9nsHkJSBbIu/T6bGXwBLljHtLzSEG8NEzrwM5lVsktGgzlwvGuIMfzkC3brg
	vWxVBTZof3Gbt3caoQjNAX+nZQDv3BHtkFprjOV+5bpll8iHmpjywc9H5a/S81TGqRFzLI539tR
	OFMdcq5TCVHZpe6D7sbDf9Cya0kJJ9kuyUDawsskdKmolkQ9MMG2R5x+ETZFCuFGjnfj8lLvjXj
	IGMlI7Gi7sevmFIO8/ojtDOwC4MLFRqiX2rOTFwnWaJqNI0R2i0r3nBqsuGQw2GTOZQdGWfaAZb
	KnjRJkzr8XbrzhMnfwqHwGSpwAQdTc0TsoWPFw//rB+dpIFkoWinxc0yJWT9bHr5VZUHkMjexMR
	GiNFSMLEN/qr/K/bMusMnNAH9fqOS2ohIsS/uf6Jk/q80EaSx0nd7iCOhKdeU4Uk7AM3OYxymHl
	B5KYho+ltaJmX4E8KlbejhtUsjVaMUCALJLnsTIiQlvqXLNQ7gOW3O/G5Gd+R5pJyMCLp1M+7hW
	t17FZ56ZJBi3CGQWSZfWRVYNFLUbwlZbfWexDVapx0BzkkX
X-Received: by 2002:a05:6870:2e04:b0:409:7cfc:7392 with SMTP id 586e51a60fabf-4177c96b888mr1211062fac.42.1773215796875;
        Wed, 11 Mar 2026 00:56:36 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm1568938fac.16.2026.03.11.00.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:56:36 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: kuniyu@google.com,
	horms@kernel.org,
	geliang@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	atwellwea@gmail.com
Subject: [PATCH net 5/7] mptcp: refresh tcp rcv_wnd snapshot when syncing receive windows
Date: Wed, 11 Mar 2026 01:55:58 -0600
Message-Id: <20260311075600.948413-6-atwellwea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311075600.948413-1-atwellwea@gmail.com>
References: <20260311075600.948413-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPTCP rewrites the TCP shadow receive window on subflows when shared
receive-window state changes.

Once tp->rcv_wnd carries paired snapshot semantics, those subflow shadow
updates have to refresh the snapshot too. Convert the MPTCP window-sync
write sites to use the helper and keep the aggregate receive-space
arithmetic using the explicit rwnd-availability helper.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 net/mptcp/options.c  | 12 ++++++++----
 net/mptcp/protocol.h | 14 +++++++++++---
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 43df4293f58b..6e6aa084cbfa 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1073,9 +1073,12 @@ static void rwin_update(struct mptcp_sock *msk, struct sock *ssk,
 		return;
 
 	/* Some other subflow grew the mptcp-level rwin since rcv_wup,
-	 * resync.
+	 * resync. Keep the TCP shadow window in its advertised u32 domain
+	 * and refresh the advertise-time scaling snapshot while doing so.
 	 */
-	tp->rcv_wnd += mptcp_rcv_wnd - subflow->rcv_wnd_sent;
+	tcp_set_rcv_wnd(tp, min_t(u64, (u64)tp->rcv_wnd +
+				  (mptcp_rcv_wnd - subflow->rcv_wnd_sent),
+				  U32_MAX));
 	subflow->rcv_wnd_sent = mptcp_rcv_wnd;
 }
 
@@ -1334,11 +1337,12 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 	if (rcv_wnd_new != rcv_wnd_old) {
 raise_win:
 		/* The msk-level rcv wnd is after the tcp level one,
-		 * sync the latter.
+		 * sync the latter and refresh its advertise-time scaling
+		 * snapshot.
 		 */
 		rcv_wnd_new = rcv_wnd_old;
 		win = rcv_wnd_old - ack_seq;
-		tp->rcv_wnd = min_t(u64, win, U32_MAX);
+		tcp_set_rcv_wnd(tp, min_t(u64, win, U32_MAX));
 		new_win = tp->rcv_wnd;
 
 		/* Make sure we do not exceed the maximum possible
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0bd1ee860316..4ea95c9c0c7a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -408,11 +408,19 @@ static inline int mptcp_space_from_win(const struct sock *sk, int win)
 	return __tcp_space_from_win(mptcp_sk(sk)->scaling_ratio, win);
 }
 
+/* MPTCP exposes window space from the mptcp-level receive queue, so it tracks
+ * a separate backlog counter from the subflow backlog embedded in struct sock.
+ */
+static inline int mptcp_rwnd_avail(const struct sock *sk)
+{
+	return READ_ONCE(sk->sk_rcvbuf) -
+	       READ_ONCE(mptcp_sk(sk)->backlog_len) -
+	       tcp_rmem_used(sk);
+}
+
 static inline int __mptcp_space(const struct sock *sk)
 {
-	return mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) -
-				    READ_ONCE(mptcp_sk(sk)->backlog_len) -
-				    sk_rmem_alloc_get(sk));
+	return mptcp_win_from_space(sk, mptcp_rwnd_avail(sk));
 }
 
 static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
-- 
2.34.1

