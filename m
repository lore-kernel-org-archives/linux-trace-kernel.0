Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795760850;
	b=SSIubj8RhulxMkdPabd+rumRb0Lg1I0k1XHc0o0+fVmYeuOU+clsP5bcgxFrakTL51Xm
	 v/ohi/zq79AoGhu5ZUI5OE908kYbyS5EkBOddEh9ThTmlrf4N+zei7uqS+ikGSR7uFOFg
	 vzrZJsKZSlo34LRhZRa3Seegmqx/efNbZwxmRPG3UBXNb5N/ZLpLlttMTiReOIJiMT1wM
	 1ls9dL8DYBh5BIttXxqjglqq5sBJlvzz6HLRECJmnycm8h5lW2h20d6y51k5sjB2uZh9v
	 b3nIL6GiLoQP9zt6l8HBNFU4gb0gN339l+p1y7il4LN/dPyzmN41JyKhRiOuoyq3gaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795760850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=maKflaiPp/YK1JfzITWg8f5N71eYZK+7tr9+lBawIHo=;
	b=pAxuwRvv0iAUX1D2xM5XlAsgDsu8d2WAE5N3Et8c6Aox0HvUD9kk3FvysFxk+71zbuS3
	 9/Z64TscCTcWmRybdX4Ka4SxvzvDBMaoSyjyT36hBbJpZHySlCetCwlPEsaIhkiCQbhp/
	 ERSLh/GpWPnk84I137L096v782JIRL1DZQe3JDJSy/ArnDf3gdhzvQC1d9m6YQCuLp4Ne
	 4dcIMBjnqukHna9MZG9alnHk6xDwzNe4qipzd7ZehzSEIKIbkWCB+tBMURsF/Ab/Rhxw+
	 WgLxoglwa8wUbtwKmOgkqU9Ne9m5IDz4Jle5ZSCsgBg7ZmoOP12GKtY4cf8i1Xn35Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PBa37k0G;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2BE606A321
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 06:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B2BE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PBa37k0G
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2f04bea9a93so67586255ad.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 22:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795760849; x=1796365649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=maKflaiPp/YK1JfzITWg8f5N71eYZK+7tr9+lBawIHo=;
        b=PBa37k0GAQumJZ2sDnKOS2knZp4Ri0rt0wDlkI9grkQr2AoAmol4KFeyQBXGMBflaM
         jOpyZHOOEczvzxAxW6veFVtImuflK/rNxgASiTx4okJvFXFCxnDJ6ig5T0c7G7mMIS8u
         wW7qrgl26yc2EX4bMyEtIuqkAn2d1BtRCjarMLNY12F1OQhwi06TJnBNol68K86qxmyR
         x521HYO5gA2Imi3I32cy6iYMQaGWX4xPlV/kYMW2Kxat2UASqXgv5feDagDq1j8oT1CL
         aw012OsTNR/udu0EZGTE6ahe3v9cAgYJ3bJEPfYBpLqTGScFEgip4NVZOV9TvpZKY0Ka
         9TBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795760849; x=1796365649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=maKflaiPp/YK1JfzITWg8f5N71eYZK+7tr9+lBawIHo=;
        b=NqSjy/WQQlNRLdZ3HSxrGniFnkGJZ7KiyjoLze1/lsTxCnI0hwXyorAv095zrQBwjC
         l21SZYZlDEuP2BQqYogqShmZzilFIy+6v4Ir3CENo222LjU8MSyxLYcEDNelQcYxc9bv
         tmJzzYnnuSRe5oWOP/+JHK0L/cdlavfoJQ25r2hwKp9BBNBgT4L5MRZwXTE1KAhvqyMM
         GXQWFvrYgUv6SpdMFg6xSKSOv5vCytwCIKBI8UAq2ZwK3QAxrM9aumtZMqzzizfojGF9
         4eLhV6SsY/x6jTKqW+wh+riyLAwcr2FKfRdnKsn0c4CPZqjjkaFIfLnEBWOoI1GKjd8G
         hqeg==
X-Forwarded-Encrypted: i=1; AL+hErFhsWXQYlsVbsSgq+skfCCBNUC0J4Pe3koHxqhbsWBo0spHnhSis28oHcCd3IWirPutqFNhoDwsVH9LgT1l2Hl3voo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8stk3s4AyOGjBg1wWUX/gH2lMRM8WR5RKpGFPsA0oFljpb1qy9
	9VhebHHSMgJ4BZjqDbc24VJWEBBzXCilywNiegyUKFS19CJ8tLcj2vzL
X-Gm-Gg: AZFdTZdjKukw71kF6Mu6yJ02ixoo67xkqyScu3hAtxUyS4zTfJktmjlsLbZzQcDocip
	7C1DgVx1LY4/G3wdZxOpGDipcxDqKjPODrUhLko4OGL+gmE6iJe5fhvgTn0JbgLrYyvcr054Atr
	5/+dnBs8QPgj43IK9b8eE+Inm0ZBHWz6IFrh/0JjqZLbxvGsLic/zDfffJwGsNUHQPaS+soQG1u
	OwGc4tlGl0x7AVk4CwB/Tiykx6Pq6JoQFaeK38wXWIjEMBTiLj+WRREKiGZQm2IWQDvzakVABjX
	BDZ6PV3FC3d7/kuhaewGPuYe7teoyNF3FuP4dKVA7UXpQGAsYEbuXuXmGx7Ru8uoPR5/C3arWta
	ZuEXaMTqLaBY8XcnhoiCz0ft3dqObb0blvMq3uhM6p8zeYLVu1nE8WPS7DMw9FQdGV7Et5iPqSy
	q3l7ka8Howo7atcctBhNyaa9UtvBmAcOm8hyGOeSg5fM3H1SIY3NSDugElqYTdXRdOVjtcSAVp8
	0zgYzn5jHFG2KLEa73+VCIjiqWNq6nPOy4F00Q1oonK2fhgnON7tT7QjXLdJKq44app2hb9SFhx
	vayO2uG5bpSV+EoOohHXx0no8GL5pb53AmRfIrcFw6EPUEIfXA==
X-Received: by 2002:a17:90b:4983:b0:3b4:ba6:f712 with SMTP id 98e67ed59e1d1-3b41c9988f1mr25740776a91.60.1795760848600;
        Thu, 26 Nov 2026 22:27:28 -0800 (PST)
Received: from dbg-srv ([111.194.74.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b82e624sm15986522a91.4.2026.11.26.22.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 22:27:28 -0800 (PST)
From: Jia Jia <physicalmtea@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next v6 1/2] vsock/virtio: split socket lookup from locked RX processing
Date: Fri, 27 Nov 2026 06:26:59 +0000
Message-ID: <20261127062700.29387-2-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127062700.29387-1-physicalmtea@gmail.com>
References: <20261127062700.29387-1-physicalmtea@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split virtio_transport_recv_pkt() so socket lookup is separate from
processing that occurs while holding the socket lock. This prepares the
receive path to retain a looked-up socket across multiple packets in a
later change.

Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
Pass the caller-provided network namespace to the locked helper so reset
handling retains its existing semantics. Preserve source validation and
failure handling.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 132 ++++++++++++++----------
 1 file changed, 78 insertions(+), 54 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f225f53ed4bab..bebf63115b263 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1774,6 +1774,80 @@ static bool virtio_transport_valid_type(u16 type)
 	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
 }
 
+static struct sock *
+virtio_transport_find_socket(struct sockaddr_vm *src,
+			     struct sockaddr_vm *dst, struct net *net)
+{
+	struct sock *sk;
+
+	sk = vsock_find_connected_socket_net(src, dst, net);
+	if (!sk)
+		sk = vsock_find_bound_socket_net(dst, net);
+
+	return sk;
+}
+
+/*
+ * The caller holds sk's socket lock.
+ */
+static void
+virtio_transport_recv_pkt_locked(struct virtio_transport *t,
+				 struct sk_buff *skb, struct sock *sk,
+				 struct net *net)
+{
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct vsock_sock *vsk = vsock_sk(sk);
+	struct sockaddr_vm src;
+	bool space_available;
+
+	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
+			le32_to_cpu(hdr->src_port));
+
+	/*
+	 * The socket may have been closed or reassigned after lookup but before
+	 * its socket lock was acquired. Listener sockets have no assigned
+	 * transport.
+	 */
+	if (sock_flag(sk, SOCK_DONE) ||
+	    (sk->sk_state != TCP_LISTEN &&
+	     !vsock_check_source(vsk, &t->transport, &src))) {
+		(void)virtio_transport_reset_no_sock(t, skb, net);
+		kfree_skb(skb);
+		return;
+	}
+
+	space_available = virtio_transport_space_update(sk, skb);
+
+	/* Update CID in case it has changed after a transport reset event */
+	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
+		vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
+
+	if (space_available)
+		sk->sk_write_space(sk);
+
+	switch (sk->sk_state) {
+	case TCP_LISTEN:
+		virtio_transport_recv_listen(sk, skb, t);
+		kfree_skb(skb);
+		break;
+	case TCP_SYN_SENT:
+		virtio_transport_recv_connecting(sk, skb);
+		kfree_skb(skb);
+		break;
+	case TCP_ESTABLISHED:
+		virtio_transport_recv_connected(sk, skb);
+		break;
+	case TCP_CLOSING:
+		virtio_transport_recv_disconnecting(sk, skb);
+		kfree_skb(skb);
+		break;
+	default:
+		(void)virtio_transport_reset_no_sock(t, skb, net);
+		kfree_skb(skb);
+		break;
+	}
+}
+
 /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
  * lock.
  */
@@ -1782,9 +1856,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct sockaddr_vm src, dst;
-	struct vsock_sock *vsk;
 	struct sock *sk;
-	bool space_available;
 
 	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
 			le32_to_cpu(hdr->src_port));
@@ -1808,13 +1880,10 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	/* The socket must be in connected or bound table
 	 * otherwise send reset back
 	 */
-	sk = vsock_find_connected_socket_net(&src, &dst, net);
+	sk = virtio_transport_find_socket(&src, &dst, net);
 	if (!sk) {
-		sk = vsock_find_bound_socket_net(&dst, net);
-		if (!sk) {
-			(void)virtio_transport_reset_no_sock(t, skb, net);
-			goto free_pkt;
-		}
+		(void)virtio_transport_reset_no_sock(t, skb, net);
+		goto free_pkt;
 	}
 
 	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
@@ -1828,53 +1897,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		goto free_pkt;
 	}
 
-	vsk = vsock_sk(sk);
-
 	lock_sock(sk);
-
-	/* Check if sk has been closed or assigned to another transport before
-	 * lock_sock (note: listener sockets are not assigned to any transport)
-	 */
-	if (sock_flag(sk, SOCK_DONE) ||
-	    (sk->sk_state != TCP_LISTEN &&
-	     !vsock_check_source(vsk, &t->transport, &src))) {
-		(void)virtio_transport_reset_no_sock(t, skb, net);
-		release_sock(sk);
-		sock_put(sk);
-		goto free_pkt;
-	}
-
-	space_available = virtio_transport_space_update(sk, skb);
-
-	/* Update CID in case it has changed after a transport reset event */
-	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
-		vsk->local_addr.svm_cid = dst.svm_cid;
-
-	if (space_available)
-		sk->sk_write_space(sk);
-
-	switch (sk->sk_state) {
-	case TCP_LISTEN:
-		virtio_transport_recv_listen(sk, skb, t);
-		kfree_skb(skb);
-		break;
-	case TCP_SYN_SENT:
-		virtio_transport_recv_connecting(sk, skb);
-		kfree_skb(skb);
-		break;
-	case TCP_ESTABLISHED:
-		virtio_transport_recv_connected(sk, skb);
-		break;
-	case TCP_CLOSING:
-		virtio_transport_recv_disconnecting(sk, skb);
-		kfree_skb(skb);
-		break;
-	default:
-		(void)virtio_transport_reset_no_sock(t, skb, net);
-		kfree_skb(skb);
-		break;
-	}
-
+	virtio_transport_recv_pkt_locked(t, skb, sk, net);
 	release_sock(sk);
 
 	/* Release refcnt obtained when we fetched this socket out of the
-- 
2.53.0

